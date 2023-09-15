package com.sev7en.chatsphere.Adapters

import android.annotation.SuppressLint
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.WindowManager
import android.widget.PopupWindow
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.google.firebase.auth.FirebaseAuth
import com.sev7en.chatsphere.R

class MessageRecyclerViewAdapter(private val listner: MessageItemClicked): RecyclerView.Adapter<RecyclerView.ViewHolder>() {

    // message list
    private val messageList: ArrayList<MessageDataModel> = ArrayList()

    // Create two variables to differentiate between the sender and reciver while on oncreateViewHolder
    private val ITEM_RECIEVE = 1
    private val ITEM_SENT = 2


    inner class SenderViewHolder(itemView: View): RecyclerView.ViewHolder(itemView) {
        val sentMessage: TextView = itemView.findViewById(R.id.tv_sender_text)
    }
    inner class ReceiverViewHolder(itemView: View): RecyclerView.ViewHolder(itemView) {
        val recievedMessage: TextView = itemView.findViewById(R.id.tv_reciver_text)
    }



    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {

        // checks view type from overridden method to inflate the message layout
        // Inflate appropriate layout based on viewType
        val layoutId = if (viewType == ITEM_SENT) R.layout.sender_layout else R.layout.reciver_layout
        val view = LayoutInflater.from(parent.context).inflate(layoutId, parent, false)

        return when (viewType) {
            ITEM_SENT -> {
                val viewHolder = SenderViewHolder(view)
                setupClickListener(viewHolder, true)
                viewHolder
            }
            else -> {
                val viewHolder = ReceiverViewHolder(view)
                setupClickListener(viewHolder, false)
                viewHolder
            }
        }
    }
    private fun setupClickListener(viewHolder: RecyclerView.ViewHolder, isSender: Boolean) {
        // detect long click on a item
        viewHolder.itemView.setOnLongClickListener {
            val message = messageList[viewHolder.adapterPosition]
            showPopupWindow(viewHolder.itemView, message, isSender)
            true
        }
    }

    // custom pop up menu to show near the message item long pressed
    @SuppressLint("InflateParams")
    private fun showPopupWindow(anchorView: View, message: MessageDataModel, isSender: Boolean) {
        val popupView = LayoutInflater.from(anchorView.context).inflate(R.layout.custom_popup, null)
        val popupWindow = PopupWindow(popupView, WindowManager.LayoutParams.WRAP_CONTENT, WindowManager.LayoutParams.WRAP_CONTENT, true)

        val copyTextView = popupView.findViewById<TextView>(R.id.copy)
        val deleteTextView = popupView.findViewById<TextView>(R.id.delete)

        copyTextView.setOnClickListener {
            // Handle copy action for the clicked message
            // Implement a function to copy text to clipboard
            listner.onItemLongClick(message, ActionType.COPY)

            popupWindow.dismiss()
        }

        deleteTextView.setOnClickListener {
            // Handle delete action for the clicked message
            popupWindow.dismiss()

            // Notify the listener of the delete action
            listner.onItemLongClick(message, ActionType.DELETE)
        }

        // Show the popup near or above the clicked message
        popupWindow.showAsDropDown(anchorView)
    }



    override fun getItemCount(): Int {
        return messageList.size
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {

        val currentMessage = messageList[position]

        if (holder.javaClass == SenderViewHolder::class.java) {
            // handle sender view holder

            val viewHolder = holder as SenderViewHolder
            holder.sentMessage.text = currentMessage.message

        } else {
            // handle receiver View holder

            val viewHolder = holder as ReceiverViewHolder
            holder.recievedMessage.text = currentMessage.message

        }
    }

    // returns integer depending upon the view type
    override fun getItemViewType(position: Int): Int {
        val currentMessage = messageList[position]

        return if (FirebaseAuth.getInstance().currentUser?.uid.equals(currentMessage.senderId)) {
            ITEM_SENT
        } else {
            ITEM_RECIEVE
        }

    }

    @SuppressLint("NotifyDataSetChanged")
    fun updateList (updatedList : ArrayList<MessageDataModel>) {
        messageList.clear()

        Log.d("Dev", "messageList is Cleared")

        messageList.addAll(updatedList)

        // this calls the three override fun again for us to update the list
        notifyDataSetChanged()

        Log.d("Dev", "Messages Updated")
    }
}

interface MessageItemClicked {
    fun onItemClicked (message: MessageDataModel)
    fun onItemLongClick(message: MessageDataModel, action: ActionType): Boolean
}
enum class ActionType {
    COPY,
    DELETE
}