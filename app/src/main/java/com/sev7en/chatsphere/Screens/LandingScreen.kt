package com.sev7en.chatsphere.Screens


import android.content.Intent
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.ActionBarDrawerToggle
import androidx.appcompat.widget.Toolbar
import androidx.core.view.GravityCompat
import androidx.drawerlayout.widget.DrawerLayout
import com.google.android.material.navigation.NavigationView
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.database.DataSnapshot
import com.google.firebase.database.DatabaseError
import com.google.firebase.database.DatabaseReference
import com.google.firebase.database.FirebaseDatabase
import com.google.firebase.database.ValueEventListener
import com.sev7en.chatsphere.R

class LandingScreen : AppCompatActivity() {

    private lateinit var drawerLayout: DrawerLayout
    private lateinit var navView: NavigationView
    private lateinit var toolbar: Toolbar

    private lateinit var mAuth: FirebaseAuth
    private lateinit var mDbRef: DatabaseReference

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_landing_screen)

        // Initialize mAuth
        mAuth = FirebaseAuth.getInstance()
        mDbRef = FirebaseDatabase.getInstance().getReference("chatsphere")

        val loggedInUserUid = mAuth.uid

        // Initialize views
        drawerLayout = findViewById(R.id.drawer_layout)
        navView = findViewById(R.id.nav_view)
        toolbar = findViewById(R.id.toolbar)

        setSupportActionBar(toolbar)

        // Set up the hamburger icon
        val toggle = ActionBarDrawerToggle(
            this, drawerLayout, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close
        )
        drawerLayout.addDrawerListener(toggle)
        toggle.syncState()

        // transferring the logged in user' userId to the homeFragment
        val homeFragment = HomeFragment()

        //by default home fragment is visible so placing home fragment
        supportFragmentManager.beginTransaction()
            .replace(R.id.container, homeFragment)
            .commit()


        // on clicking profile pic in navigation bar profile fragment is switched
        val navHeader = navView.getHeaderView(0)
        val userImageView = navHeader.findViewById<ImageView>(R.id.profile_image)
        val profileName = navHeader.findViewById<TextView>(R.id.profile_name)


        // setting the image, name of current user in the view
        val user = mDbRef
            .child("User")
            .child(loggedInUserUid!!)

        user.child("userImage")
            .addListenerForSingleValueEvent(object : ValueEventListener {
                override fun onDataChange(snapshot: DataSnapshot) {
                    //get the userImage
                    val userImage = snapshot.value.toString()

                }

                override fun onCancelled(error: DatabaseError) {
                    Log.e("Dev", "$error")
                }

            })
        user.child("userName")
            .addListenerForSingleValueEvent(object : ValueEventListener {
                override fun onDataChange(snapshot: DataSnapshot) {
                    if (snapshot.exists()) {

                        //get the username
                        val userName = snapshot.value.toString()

                        profileName.text = userName
                    }
                }

                override fun onCancelled(error: DatabaseError) {
                    Log.e("Dev", "$error")
                }

            })



        // on clicking the user pic the profile fragment is opened
        userImageView.setOnClickListener {
            val profileFragment = ProfileFragment()
            supportFragmentManager.beginTransaction()
                .replace(R.id.container, profileFragment)
                .commit()

            // if a profile item is present in the menu items then,
            // Optionally, you can highlight/select the "Profile" item in the navigation drawer.
            // navView.setCheckedItem(R.id.nav_profile)

            drawerLayout.closeDrawer(GravityCompat.START)
        }


        // on clicking any of the items of the navigation bar action
        navView.setNavigationItemSelectedListener { menuItem ->
            when (menuItem.itemId) {
                R.id.nav_invite_friends -> {
                    val inviteLink = "https://github.com/Mahaveer86619/ChatSphere"
                    val intent = Intent(Intent.ACTION_VIEW, Uri.parse(inviteLink))
                    startActivity(intent)
                }
                R.id.nav_settings -> {
                    val settingsFragment = SettingsFragment()
                    supportFragmentManager.beginTransaction()
                        .replace(R.id.container, settingsFragment)
                        .commit()
                }
                R.id.nav_home -> {
                    supportFragmentManager.beginTransaction()
                        .replace(R.id.container, HomeFragment())
                        .commit()
                }
                R.id.log_out -> {

                    Log.d("Dev", "signed out")
                    mAuth.signOut()
                    startActivity(Intent(this,LoginScreen::class.java))
                    finish()
                }
                // Add other cases for different menu items as needed
            }
            drawerLayout.closeDrawer(GravityCompat.START)
            true
        }



    }
}