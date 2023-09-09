package com.sev7en.chatsphere.Screens

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.sev7en.chatsphere.databinding.ActivitySignInScreenBinding

class SignInScreen : AppCompatActivity() {

    private lateinit var binding: ActivitySignInScreenBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivitySignInScreenBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.tvToLogIn.setOnClickListener {
            startActivity(Intent(this, LoginScreen::class.java))
            finish()
        }

        binding.mbContinue.setOnClickListener {
            startActivity(Intent(this, LandingScreen::class.java))
            finish()
        }

    }
}