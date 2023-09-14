package com.sev7en.chatsphere.Screens

import android.content.ContentValues.TAG
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import com.google.android.material.button.MaterialButton
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.database.DatabaseReference
import com.google.firebase.database.FirebaseDatabase
import com.sev7en.chatsphere.Adapters.UserDataModel
import com.sev7en.chatsphere.R
import com.sev7en.chatsphere.databinding.ActivitySignInScreenBinding

class SignInScreen : AppCompatActivity() {

    private lateinit var binding: ActivitySignInScreenBinding

    private lateinit var mAuth: FirebaseAuth
    private lateinit var mDbRef: DatabaseReference


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivitySignInScreenBinding.inflate(layoutInflater)
        setContentView(binding.root)

        mAuth = FirebaseAuth.getInstance()

        binding.tvToLogIn.setOnClickListener {
            startActivity(Intent(this, LoginScreen::class.java))
            finish()
        }

        binding.mbContinue.setOnClickListener {

            var email= ""
            var password= ""

            if (binding.tfEmail.text?.isNotEmpty() == true){
                email = binding.tfEmail.text.toString()
            } else {
                Toast.makeText(this,"email cannot be empty",Toast.LENGTH_SHORT).show()
            }
            if (binding.tfPassword.text?.isNotEmpty() == true){
                password = binding.tfPassword.text.toString()
            } else {
                Toast.makeText(this,"password cannot be empty",Toast.LENGTH_SHORT).show()
            }


            if (binding.tfReenterPass.text.toString() == binding.tfPassword.text.toString()){


                signin(email, password)


            } else {
                Toast.makeText(this,"Passwords dont match",Toast.LENGTH_SHORT).show()
            }

        }

    }


    private fun signin(email: String, password: String) {
        mAuth.createUserWithEmailAndPassword(email, password)
            .addOnCompleteListener(this) { task ->
                if (task.isSuccessful) {
                    // Sign in success, update UI with the signed-in user's information
                    Log.w("Dev", "createUserWithEmail:success")

                    addUserToDatabase(email, mAuth.currentUser?.uid!!)

                    startActivity(Intent(this,LandingScreen::class.java))
                    finish()

                } else {
                    // If sign in fails, display a message to the user.
                    Log.w("Dev", "createUserWithEmail:failure", task.exception)
                    Toast.makeText(
                        baseContext,
                        "Authentication failed.",
                        Toast.LENGTH_SHORT,
                    ).show()
                }
            }
    }

    private fun addUserToDatabase (email: String, uid: String) {

        mDbRef = FirebaseDatabase.getInstance().getReference("chatsphere")

        // stupid update the json file if the database is created before database creation it has the database link
        //setting the name to emil user can change later
        val user = UserDataModel(uid, R.drawable.default_person, "", email)
        mDbRef.child("User").child(uid).setValue(user)

        Log.d("Dev", "User added to Database")

    }


}