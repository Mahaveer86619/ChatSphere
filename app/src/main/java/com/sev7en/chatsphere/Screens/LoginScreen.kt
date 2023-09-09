package com.sev7en.chatsphere.Screens

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import com.sev7en.chatsphere.R
import com.sev7en.chatsphere.databinding.ActivityLoginScreenBinding

class LoginScreen : AppCompatActivity() {

    private lateinit var binding: ActivityLoginScreenBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityLoginScreenBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.tvToSignIn.setOnClickListener {
            startActivity(Intent(this, SignInScreen::class.java))
            finish()
        }

        binding.mbContinue.setOnClickListener {
            startActivity(Intent(this, LandingScreen::class.java))
            finish()
        }

    }
}