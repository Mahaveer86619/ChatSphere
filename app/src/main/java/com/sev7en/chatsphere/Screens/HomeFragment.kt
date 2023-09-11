package com.sev7en.chatsphere.Screens

import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.database.DataSnapshot
import com.google.firebase.database.DatabaseError
import com.google.firebase.database.DatabaseReference
import com.google.firebase.database.FirebaseDatabase
import com.google.firebase.database.ValueEventListener
import com.sev7en.chatsphere.Adapters.UserItemClicked
import com.sev7en.chatsphere.Adapters.UserDataModel
import com.sev7en.chatsphere.Adapters.UserRecyclerViewAdapter
import com.sev7en.chatsphere.R

class HomeFragment : Fragment(), UserItemClicked {

    // variables of the fragment
    private lateinit var recyclerview: RecyclerView
    private lateinit var userList: ArrayList<UserDataModel>
    private lateinit var mAuth: FirebaseAuth
    private lateinit var mDbRef: DatabaseReference

    // Get the FirebaseUser object
    val user = FirebaseAuth.getInstance().currentUser

    // Get the UID of the logged-in user
    val loggedInUserUid = user?.uid

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_home, container, false)
    }


    // Code of the Fragment
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        // Initialize mAuth
        mAuth = FirebaseAuth.getInstance()
        mDbRef = FirebaseDatabase.getInstance().getReference("chatsphere")

        // Initialize userList
        userList = ArrayList()


        //linking recycler view
        recyclerview = view.findViewById(R.id.recyclerview)
        recyclerview.layoutManager = LinearLayoutManager(context)
        val adapter = UserRecyclerViewAdapter(this)
        recyclerview.adapter = adapter


        // use database reference to get all users
        mDbRef.child("User").addValueEventListener(object : ValueEventListener{
            override fun onDataChange(snapshot: DataSnapshot) {

                //get all users by iterating through the child User using snapshot
                for(postSnapshot in snapshot.children) {

                    val currentUser = postSnapshot.getValue(UserDataModel::class.java)

                    if (currentUser != null) {
//                        if (currentUser.uid == loggedInUserId) {
//                            currentUser.userName = "Message Yourself"
//
//                        }

                        if (currentUser.uid == loggedInUserUid) {
                            // If the UID matches, change the name to "Message Yourself"
                            currentUser.userName = "Message Yourself"
                        } else {
                            // If the UID doesn't match, replace the name with the email
                            currentUser.userName = currentUser.email
                        }
                    }

                    userList.add(currentUser!!)

                }
                Log.d("Dev", "Added users in list")
                adapter.updateList(userList)

            }

            override fun onCancelled(error: DatabaseError) {
                Log.e("Dev", "Error: ${error.message}")
            }

        })
    }

    override fun onItemClicked(user: UserDataModel) {

        Log.d("Dev", "${user.userName} clicked, Redirecting to chat screen")

        val intent = Intent(context, ChatScreen::class.java)

        intent.putExtra("Receiver_name", user.userName)
        intent.putExtra("Receiver_uid", user.uid)

        context?.startActivity(intent)

    }


}