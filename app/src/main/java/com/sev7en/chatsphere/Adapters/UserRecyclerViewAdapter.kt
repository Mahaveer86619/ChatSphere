package com.sev7en.chatsphere.Adapters

import android.annotation.SuppressLint
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.sev7en.chatsphere.R
import de.hdodenhof.circleimageview.CircleImageView

class UserRecyclerViewAdapter(private val listner : UserItemClicked) : RecyclerView.Adapter<UserRecyclerViewAdapter.UserViewHolder>() {

    private val itemList :ArrayList<UserDataModel> = ArrayList()

    inner class UserViewHolder(itemView : View) : RecyclerView.ViewHolder(itemView) {
        val userImage = itemView.findViewById<CircleImageView>(R.id.userImage)
        val userName = itemView.findViewById<TextView>(R.id.username)
        val lastMessage = itemView.findViewById<TextView>(R.id.lastmessage)
        val timeSent = itemView.findViewById<TextView>(R.id.timesent)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): UserViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.recyclerview_items, parent, false)
        val viewHolder = UserViewHolder(view)
        view.setOnClickListener{
            listner.onItemClicked(itemList[viewHolder.adapterPosition])
        }

        return viewHolder
    }

    override fun getItemCount(): Int {
        return itemList.size
    }

    override fun onBindViewHolder(holder: UserViewHolder, position: Int) {
        val currentItem = itemList[position]

        holder.userName.text = currentItem.userName
//        holder.lastMessage.text = currentItem.userLastMessage
//        holder.timeSent.text = currentItem.timeSent

        Glide.with(holder.itemView.context)
            .load(currentItem.userImage)
            .into(holder.userImage)
    }

    @SuppressLint("NotifyDataSetChanged")
    fun updateList (updatedList : ArrayList<UserDataModel>) {
        itemList.clear()

        Log.d("Dev", "userList is Cleared")

        itemList.addAll(updatedList)

        // this calls the three overriden fun again for us to update the list
        notifyDataSetChanged()

        Log.d("Dev", "Dataset Updated")
    }
}
interface UserItemClicked {
    fun onItemClicked(user : UserDataModel)
}