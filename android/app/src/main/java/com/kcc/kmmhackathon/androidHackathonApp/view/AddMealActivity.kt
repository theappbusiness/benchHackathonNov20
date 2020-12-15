package com.kcc.kmmhackathon.androidHackathonApp.view

import android.os.Bundle
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import com.kinandcarta.lib.add.meal.view.AddMealFragment

class AddMealActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (savedInstanceState == null) {
            supportFragmentManager.beginTransaction()
                .replace(android.R.id.content, AddMealFragment.newInstance())
                .commit()
        }
    }
    
}