package com.kcc.kmmhackathon.androidHackathonApp

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.navigation.fragment.NavHostFragment
import androidx.navigation.ui.NavigationUI
import com.google.android.material.bottomnavigation.BottomNavigationView
import com.kcc.kmmhackathon.androidHackathonApp.view.AddMealActivity
import com.kinandcarta.lib.find.meal.view.FindMealActivity

class MainActivity : AppCompatActivity() {

    private lateinit var bottomNavigationView: BottomNavigationView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        setTitle(R.string.app_name)

        bottomNavigationView = findViewById(R.id.bottom_nav)

        val navHostFragment = supportFragmentManager
            .findFragmentById(R.id.nav_host_fragment_container) as NavHostFragment?
        NavigationUI.setupWithNavController(
            bottomNavigationView,
            navHostFragment!!.navController
        )

        val intent = Intent(this, AddMealActivity::class.java)
        startActivity(intent)

        val intent2 = Intent(this, FindMealActivity::class.java)
        startActivity(intent)
    }
}
