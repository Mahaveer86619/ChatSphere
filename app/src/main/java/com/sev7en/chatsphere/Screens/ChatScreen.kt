package com.sev7en.chatsphere.Screens

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.appcompat.widget.Toolbar
import com.sev7en.chatsphere.R

class ChatScreen : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_chat_screen)

        // Initialize the Toolbar
        val toolbar: Toolbar = findViewById(R.id.chat_toolbar)
        setSupportActionBar(toolbar)

        // Enable the back button in the Toolbar
        supportActionBar?.setDisplayHomeAsUpEnabled(true)



    }
}