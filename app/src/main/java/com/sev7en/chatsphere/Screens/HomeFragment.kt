package com.sev7en.chatsphere.Screens

import android.app.AlertDialog
import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.EditText
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
    private var mAuth = FirebaseAuth.getInstance()
    private val mDbRef = FirebaseDatabase.getInstance().getReference("chatsphere")

    // Get the FirebaseUser object
    val user = mAuth.currentUser


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

        // Initialize userList
        userList = ArrayList()

        //show dialogue box if userName is empty
        currentUserNameIsNotEmpty { userName ->

            if (!userName) {
                showEnterNameDialog()
            }

        }

        //linking recycler view
        recyclerview = view.findViewById(R.id.recyclerview)
        recyclerview.layoutManager = LinearLayoutManager(context)
        val adapter = UserRecyclerViewAdapter(this)
        recyclerview.adapter = adapter


        // use database reference to get all users
        mDbRef.child("User").addValueEventListener(object : ValueEventListener{
            override fun onDataChange(snapshot: DataSnapshot) {

                //TODO bellow code is to be used but it crashes
                userList.clear()

                //get all users by iterating through the child User using snapshot
                for(postSnapshot in snapshot.children) {

                    val currentUser = postSnapshot.getValue(UserDataModel::class.java)

                    if (currentUser!!.uid == loggedInUserUid) {
                        // If the UID matches, change the name to "Message Yourself"
                        currentUser.userName = "Message Yourself"
                    }

                    userList.add(currentUser)

                }

                Log.d("Dev", "Added users in list")
                adapter.updateList(userList)

            }

            override fun onCancelled(error: DatabaseError) {
                Log.e("Dev", "Error: ${error.message}")
            }

        })

    }

    private fun currentUserNameIsNotEmpty (callback: (Boolean) -> Unit) {

        mDbRef
            .child("User")
            .child(loggedInUserUid!!)
            .child("userName")
            .addListenerForSingleValueEvent(object : ValueEventListener{
                override fun onDataChange(snapshot: DataSnapshot) {
                    if (snapshot.exists()) {

                        //get the username
                        val userName = snapshot.value.toString()

                        //callback saying username is not present
                        if (userName == "") {
                            callback(false)
                        }
                    }
                }

                override fun onCancelled(error: DatabaseError) {
                    Log.e("Dev", "$error")
                }

            })
    }

    private fun showEnterNameDialog() {
        val dialogView = layoutInflater.inflate(R.layout.dialog_enter_name, null)
        val etName = dialogView.findViewById<EditText>(R.id.tf_name)

        val dialog = AlertDialog.Builder(context)
            .setView(dialogView)
            .setTitle("Enter Your Unique Name")
            .setPositiveButton("Confirm") { _, _ ->

                //to remove leading and trailing empty spaces .trim() is used
                val enteredName = etName.text.toString().trim()

                if (enteredName == "") {
                    //username cannot be empty
                    Toast.makeText(context, "Username cannot be empty", Toast.LENGTH_SHORT).show()

                    showEnterNameDialog()

                } else {

                    // Check if the entered name is unique in the database
                    isInputUnique(enteredName) { isUnique ->
                        if (isUnique) {

                            // The name is unique, you can proceed to save it in the database
                            saveNameToDatabase(enteredName)

                        } else {

                            // The name is not unique, show an error message to the user
                            Toast.makeText(context, "Name is already taken, please choose another.", Toast.LENGTH_SHORT).show()
                            showEnterNameDialog()

                        }
                    }
                }

            }
            .setNegativeButton("Cancel") { dialog, _ ->
                dialog.dismiss()
            }
            .create()

        dialog.show()
    }
    private fun isInputUnique(name: String, callback: (Boolean) -> Unit) {

        // Query the database to check if the username already exists
        val query = mDbRef.child("User").orderByChild("username").equalTo(name)

        query.addListenerForSingleValueEvent(object : ValueEventListener {
            override fun onDataChange(dataSnapshot: DataSnapshot) {
                // If dataSnapshot.exists() is true, it means the username is not unique
                callback(!dataSnapshot.exists())
            }

            override fun onCancelled(databaseError: DatabaseError) {
                // Handle errors, if any
                Log.e("Dev", "$databaseError")
                callback(false) // Consider it not unique in case of an error
            }
        })
    }

    private fun saveNameToDatabase(name: String) {

        mDbRef.child("User").child(loggedInUserUid!!).child("userName").setValue(name)


        Log.d("Dev", "userName set $name")
    }

    override fun onItemClicked(user: UserDataModel) {

        Log.d("Dev", "${user.userName} clicked, Redirecting to chat screen")

        val intent = Intent(context, ChatScreen::class.java)

        intent.putExtra("Receiver_name", user.userName)
        intent.putExtra("Receiver_uid", user.uid)

        context?.startActivity(intent)

    }


}