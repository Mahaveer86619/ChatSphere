package com.sev7en.chatsphere.Screens


import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.ImageView
import android.widget.Toast
import androidx.appcompat.app.ActionBarDrawerToggle
import androidx.appcompat.widget.Toolbar
import androidx.core.view.GravityCompat
import androidx.drawerlayout.widget.DrawerLayout
import com.google.android.material.navigation.NavigationView
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.database.DatabaseReference
import com.google.firebase.database.FirebaseDatabase
import com.sev7en.chatsphere.R

class LandingScreen : AppCompatActivity() {

    private lateinit var drawerLayout: DrawerLayout
    private lateinit var navView: NavigationView
    private lateinit var toolbar: Toolbar

    private lateinit var mAuth: FirebaseAuth

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_landing_screen)

        // Receiving the passed userId through intent
        val loggedInUserId = intent.getStringExtra("user_id")

        // Initialize mAuth
        mAuth = FirebaseAuth.getInstance()

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
        val homeFragment = HomeFragment.newInstance(loggedInUserId)

        //by default home fragment is visible so placing home fragment
        supportFragmentManager.beginTransaction()
            .replace(R.id.container, homeFragment)
            .commit()

        // on clicking profile pic in navigation bar profile fragment is switched
        val navHeader = navView.getHeaderView(0)
        val userImageView = navHeader.findViewById<ImageView>(R.id.profile_image)

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
                    Toast.makeText(this,"U have no friends",Toast.LENGTH_SHORT).show()
                }
                R.id.nav_settings -> {
                    val settingsFragment = SettingsFragment()
                    supportFragmentManager.beginTransaction()
                        .replace(R.id.container, settingsFragment)
                        .commit()
                }
                R.id.nav_home -> {
                    val homeFragment = HomeFragment()
                    supportFragmentManager.beginTransaction()
                        .replace(R.id.container, homeFragment)
                        .commit()
                }
                R.id.log_out -> {

                    Log.d("Dev", "signned out")
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