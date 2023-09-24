package com.sev7en.chatsphere.Screens

import android.app.AlertDialog
import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.EditText
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.database.DataSnapshot
import com.google.firebase.database.DatabaseError
import com.google.firebase.database.FirebaseDatabase
import com.google.firebase.database.ValueEventListener
import com.sev7en.chatsphere.R
import de.hdodenhof.circleimageview.CircleImageView


class ProfileFragment : Fragment() {

    private val mAuth = FirebaseAuth.getInstance()
    private val mDbRef = FirebaseDatabase.getInstance().getReference("chatsphere")
    private lateinit var username : TextView
    private lateinit var email : TextView
    private lateinit var profilePic : CircleImageView
    private lateinit var edit_username : ImageView

    // Get the FirebaseUser object
    val user = mAuth.currentUser

    // Get the UID of the logged-in user
    val loggedInUserUid = user?.uid

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        (requireActivity() as AppCompatActivity).supportActionBar?.title = "Profile"
        return inflater.inflate(R.layout.fragment_profile, container, false)
    }


    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        username = view.findViewById<TextView>(R.id.tv_profile_username)
        email = view.findViewById<TextView>(R.id.tv_profile_email)
        profilePic = view.findViewById<CircleImageView>(R.id.civ_profile_pic)
        edit_username = view.findViewById(R.id.iv_edit_username)

        setValues()

        edit_username.setOnClickListener {
            showEnterNameDialog()
        }



    }

    private fun setValues(){

        val currentUser = mDbRef
            .child("User")
            .child(loggedInUserUid!!)

        currentUser.child("userName").addListenerForSingleValueEvent(object : ValueEventListener{
            override fun onDataChange(snapshot: DataSnapshot) {
                username.text = snapshot.value.toString()
            }

            override fun onCancelled(error: DatabaseError) {
                Log.e("Dev", "Could not fetch Username")
            }

        })

        currentUser.child("userImage").addListenerForSingleValueEvent(object : ValueEventListener{
            override fun onDataChange(snapshot: DataSnapshot) {
                //profilePic.setImageResource()
            }

            override fun onCancelled(error: DatabaseError) {
                Log.e("Dev", "Could not fetch UserImage")
            }

        })

        currentUser.child("email").addListenerForSingleValueEvent(object : ValueEventListener{
            override fun onDataChange(snapshot: DataSnapshot) {
                email.text = snapshot.value.toString()
            }

            override fun onCancelled(error: DatabaseError) {
                Log.e("Dev", "Could not fetch email")
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

                        setValues()
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


}