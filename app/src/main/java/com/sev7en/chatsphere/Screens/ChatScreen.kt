package com.sev7en.chatsphere.Screens

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.Menu
import android.view.MenuItem
import android.widget.EditText
import android.widget.ImageButton
import android.widget.Toast
import androidx.appcompat.widget.Toolbar
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.database.DataSnapshot
import com.google.firebase.database.DatabaseError
import com.google.firebase.database.DatabaseReference
import com.google.firebase.database.FirebaseDatabase
import com.google.firebase.database.ValueEventListener
import com.sev7en.chatsphere.Adapters.MessageDataModel
import com.sev7en.chatsphere.Adapters.MessageItemClicked
import com.sev7en.chatsphere.Adapters.MessageRecyclerViewAdapter
import com.sev7en.chatsphere.Adapters.UserDataModel
import com.sev7en.chatsphere.R

class ChatScreen : AppCompatActivity(), MessageItemClicked {

    private lateinit var messageRecyclerview: RecyclerView
    private lateinit var messageBox: EditText
    private lateinit var sendBtn: ImageButton

    private lateinit var mDbRef: DatabaseReference

    var receiver_room: String? = null
    var sender_room: String? = null

    private lateinit var messageList: ArrayList<MessageDataModel>

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_chat_screen)

        // Initialize the Database
        mDbRef = FirebaseDatabase.getInstance().getReference("chatsphere")

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
        val intent = Intent()
        val receiver_uid = intent.getStringExtra("Receiver_uid")
        val receiver_name = intent.getStringExtra("Receiver_name")
        val sender_uid = FirebaseAuth.getInstance().currentUser?.uid


        // create unique room for sender and receiver
        sender_room = receiver_uid + sender_uid
        receiver_room = sender_uid + receiver_uid


        // Set the friend's name as the title
        supportActionBar?.title = receiver_name


        // recyclerview setup
        messageRecyclerview = findViewById(R.id.message_recyclerview)
        messageRecyclerview.layoutManager = LinearLayoutManager(this)
        val adapter = MessageRecyclerViewAdapter(this)
        messageRecyclerview.adapter = adapter

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
            val messageObject = MessageDataModel(message, sender_uid)

            // put the message in the database of both sender and receiver
            mDbRef
                .child("chat")
                .child(sender_room!!)
                .child("messages")
                .push()
                .setValue(messageObject)
                .addOnSuccessListener {

                    Log.d("Dev", "$messageObject Message sent")

                    // update the receiver side too
                    mDbRef
                        .child("chat")
                        .child(receiver_room!!)
                        .child("messages")
                        .push()
                        .setValue(messageObject)

                }
                .addOnCanceledListener {
                    Log.e("Dev", "Couldn't send the message")
                }

            // clear the message box after sending
            messageBox.setText("")

        }


    }

    override fun onItemClicked(message: MessageDataModel) {
        Toast.makeText(this, "${message} clicked", Toast.LENGTH_SHORT).show()


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