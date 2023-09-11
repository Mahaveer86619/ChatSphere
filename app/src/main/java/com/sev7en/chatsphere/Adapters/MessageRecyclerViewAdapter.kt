package com.sev7en.chatsphere.Adapters

import android.annotation.SuppressLint
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
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
        if (viewType == 1) {
            // inflate received message
            val view = LayoutInflater.from(parent.context).inflate(R.layout.reciver_layout, parent, false)
            val viewHolder = ReceiverViewHolder(view)
            view.setOnClickListener{
                listner.onItemClicked(messageList[viewHolder.adapterPosition])
            }

            return viewHolder

        }else {
            // inflate sent message
            val view = LayoutInflater.from(parent.context).inflate(R.layout.sender_layout, parent, false)
            val viewHolder = SenderViewHolder(view)
            view.setOnClickListener{
                listner.onItemClicked(messageList[viewHolder.adapterPosition])
            }

            return viewHolder
        }
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
}