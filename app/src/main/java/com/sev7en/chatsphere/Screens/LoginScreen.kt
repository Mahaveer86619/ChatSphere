package com.sev7en.chatsphere.Screens

import android.content.ContentValues.TAG
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import com.google.firebase.auth.FirebaseAuth
import com.sev7en.chatsphere.databinding.ActivityLoginScreenBinding

class LoginScreen : AppCompatActivity() {

    private lateinit var binding: ActivityLoginScreenBinding

    private lateinit var mAuth: FirebaseAuth

    //checks if a user is logged in. If yes then redirect to the Landing Screen
    public override fun onStart() {
        super.onStart()
        // Check if user is signed in (non-null) and update UI accordingly.
        val currentUser = mAuth.currentUser
        if (currentUser != null) {

            Log.d("Dev", "Already Signed in Redirecting to Landing Screen")

            startActivity(Intent(this,LandingScreen::class.java))
            finish()
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityLoginScreenBinding.inflate(layoutInflater)
        setContentView(binding.root)

        mAuth = FirebaseAuth.getInstance()

        binding.tvToSignIn.setOnClickListener {
            startActivity(Intent(this, SignInScreen::class.java))
            finish()
        }

        binding.mbContinue.setOnClickListener {
            var email= ""
            var password= ""

            if (binding.tfEmail.text?.isNotEmpty() == true){
                email = binding.tfEmail.text.toString()
            } else {
                Toast.makeText(this,"email cannnot be empty", Toast.LENGTH_SHORT).show()
            }
            if (binding.tfPassword.text?.isNotEmpty() == true){
                password = binding.tfPassword.text.toString()
            } else {
                Toast.makeText(this,"password cannnot be empty", Toast.LENGTH_SHORT).show()
            }

            login(email, password)

        }
    }


    private fun login(email: String, password: String) {
        mAuth.signInWithEmailAndPassword(email, password)
            .addOnCompleteListener(this) { task ->
                if (task.isSuccessful) {
                    // Sign in success, update UI with the signed-in user's information

                    Log.d("Dev", "signInWithEmail:success")

                    startActivity(Intent(this,LandingScreen::class.java))
                    finish()


                } else {
                    // If sign in fails, display a message to the user.

                    Log.w("Dev", "signInWithEmail:failure", task.exception)

                    Toast.makeText(
                        baseContext,
                        "Authentication failed.",
                        Toast.LENGTH_SHORT,
                    ).show()
                }
            }
    }


}