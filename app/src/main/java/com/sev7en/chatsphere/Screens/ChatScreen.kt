package com.sev7en.chatsphere.Screens

import android.annotation.SuppressLint
import android.content.ClipData
import android.content.ClipboardManager
import android.content.Context
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.Menu
import android.view.MenuItem
import android.widget.EditText
import android.widget.ImageButton
import android.widget.PopupMenu
import android.widget.Toast
import androidx.appcompat.widget.Toolbar
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.database.DataSnapshot
import com.google.firebase.database.DatabaseError
import com.google.firebase.database.FirebaseDatabase
import com.google.firebase.database.ValueEventListener
import com.sev7en.chatsphere.Adapters.ActionType
import com.sev7en.chatsphere.Adapters.MessageDataModel
import com.sev7en.chatsphere.Adapters.MessageItemClicked
import com.sev7en.chatsphere.Adapters.MessageRecyclerViewAdapter
import com.sev7en.chatsphere.R

class ChatScreen : AppCompatActivity(), MessageItemClicked {

    private lateinit var messageRecyclerview: RecyclerView
    private lateinit var messageBox: EditText
    private lateinit var sendBtn: ImageButton

    private val mDbRef = FirebaseDatabase.getInstance().getReference("chatsphere")
    private val mAuth = FirebaseAuth.getInstance()

    private val loggedInUserId = mAuth.currentUser?.uid

    val adapter = MessageRecyclerViewAdapter(this)

    var receiver_room: String? = null
    var sender_room: String? = null

    private lateinit var messageList: ArrayList<MessageDataModel>

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_chat_screen)

        // Initialize variables
        sendBtn = findViewById(R.id.ib_send_btn)
        messageBox = findViewById(R.id.et_message_box)
        messageList = ArrayList()

        // Initialize the Toolbar
        val toolbar: Toolbar = findViewById(R.id.chat_toolbar)
        setSupportActionBar(toolbar)

        // Enable the back button in the Toolbar
        supportActionBar?.setDisplayHomeAsUpEnabled(true)

        // Receiving the userid of recipient from intent
        // don't use intent object just use the intent got from previous screen
        val receiver_uid = intent.getStringExtra("Receiver_uid")
        val receiver_name = intent.getStringExtra("Receiver_name")
        val sender_uid = mAuth.currentUser?.uid

        // create unique room for sender and receiver
        sender_room = receiver_uid + sender_uid
        receiver_room = sender_uid + receiver_uid


        // Set the friend's name as the title
        supportActionBar?.title = receiver_name


        // recyclerview setup
        messageRecyclerview = findViewById(R.id.message_recyclerview)
        messageRecyclerview.layoutManager = LinearLayoutManager(this)
        messageRecyclerview.adapter = adapter

        messageList.clear()

        // Update the recycler view by updating the message list
        mDbRef
            .child("chat")
            .child(sender_room!!)
            .child("messages")
            .addValueEventListener(object: ValueEventListener{
                override fun onDataChange(snapshot: DataSnapshot) {

                    //get all messages by iterating through the child User using snapshot
                    for(postSnapshot in snapshot.children) {

                        val currentMessage = postSnapshot.getValue(MessageDataModel::class.java)

                        messageList.add(currentMessage!!)

                    }
                    Log.d("Dev", "Added messages in list")
                    adapter.updateList(messageList)
                }

                override fun onCancelled(error: DatabaseError) {
                    Log.e("Dev", "Error: ${error.message}")
                }

            })


        sendBtn.setOnClickListener {

            val message = messageBox.text.toString()

            if (message.isEmpty()){
                Toast.makeText(this, "message cannot be empty", Toast.LENGTH_SHORT).show()
            } else {
                //val messageObject = MessageDataModel(message, sender_uid)

                messageList.clear()

                // put the message in the database of both sender and receiver
                val senderMessageRef = mDbRef
                    .child("chat")
                    .child(sender_room!!)
                    .child("messages")

                // get the message id as it gets generated by push() by .key and include it in message object which will be (set value)
                val senderMessageId = senderMessageRef.push().key

                // Set the message in the database under the generated message ID
                senderMessageId?.let {id1 ->
                    senderMessageRef
                        .child(id1)
                        .setValue(MessageDataModel(senderMessageId, message, sender_uid))
                        .addOnSuccessListener {

                            Log.d("Dev", "message sent = $message")

                            // update the receiver side too similar to sender above if receiver is NOT the User itself
                            if (receiver_uid != loggedInUserId){
                                val receiverMessageRef = mDbRef
                                    .child("chat")
                                    .child(receiver_room!!)
                                    .child("messages")

                                val receiverMessageId = receiverMessageRef.push().key

                                // Set the message in the database under the generated message ID
                                receiverMessageId?.let {id2 ->
                                    receiverMessageRef
                                        .child(id2)
                                        .setValue(MessageDataModel(receiverMessageId, message, sender_uid))
                                        .addOnSuccessListener {
                                            Log.d("Dev", "message added in receiver database = $message")
                                        }
                                        .addOnCanceledListener {
                                            Log.e("Dev", "Couldn't add the message in receiver database")
                                        }
                                }
                            }

                        }
                        .addOnCanceledListener {
                            Log.e("Dev", "Couldn't send the message")
                        }
                }

                // clear the message box after sending
                messageBox.setText("")


            }

        }


    }

    override fun onItemClicked(message: MessageDataModel) {

        Log.d("Dev", "${message.message} clicked")

    }

    override fun onItemLongClick(message: MessageDataModel, action: ActionType): Boolean {
        Log.d("Dev", "${message.message} Long clicked")

        //action contains if copy was clicked or delete as COPY or DELETE
        when (action) {
            ActionType.COPY -> {
                // Handle the copy action
                // It will come to this fun when copy is clicked
                copyTextToClipboard(message.message!!)
            }
            ActionType.DELETE -> {
                // Handle the delete action
                val messageId = message.messageId // Assuming you have a unique message ID

                // Remove the message from the database
                mDbRef
                    .child("chat")
                    .child(sender_room!!)
                    .child("messages")
                    .child(messageId!!)
                    .removeValue()
                    .addOnSuccessListener {
                        mDbRef
                            .child("chat")
                            .child(receiver_room!!)
                            .child("messages")
                            .child(messageId)
                            .removeValue()
                            .addOnSuccessListener {
                                // Message deleted from both sender and receiver
                                Log.d("Dev", "${message.message} deleted")

                                // Remove the message from the local list
                                val position = messageList.indexOf(message)
                                if (position != -1) {
                                    messageList.removeAt(position)
                                    adapter.notifyItemRemoved(position)
                                }
                            }
                            .addOnFailureListener {
                                Log.e("Dev", "Error deleting message: ${it.message}")
                            }
                    }
                    .addOnFailureListener {
                        Log.e("Dev", "Error deleting message: ${it.message}")
                    }


                Log.d("Dev", "${message.message} deleted")
                Toast.makeText(this, "${message.message} deleted", Toast.LENGTH_SHORT).show()

            }
        }

        // return true if we handled the functionality
        return true

        // or false if we did not use the long click function and want to use the default android function of the long click

    }

    @SuppressLint("ServiceCast")
    private fun copyTextToClipboard(text: String) {
        val clipboardManager = getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
        val clipData = ClipData.newPlainText("Copied Text", text)
        clipboardManager.setPrimaryClip(clipData)

        // Show a toast or a message to indicate that text has been copied
        Toast.makeText(this, "Text copied to clipboard", Toast.LENGTH_SHORT).show()
        Log.d("Dev", "$text copied")
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.chat_menu, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        return when (item.itemId) {
            R.id.menu_clear_chat -> {

                Toast.makeText(this, "Clear all chat", Toast.LENGTH_SHORT).show()

                // Handle "Clear Chat" option click
                // Show a confirmation dialog and clear the chat history
                true
            }

            else -> super.onOptionsItemSelected(item)
        }
    }

}