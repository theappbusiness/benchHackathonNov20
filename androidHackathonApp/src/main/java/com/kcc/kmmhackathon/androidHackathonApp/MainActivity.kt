package com.kcc.kmmhackathon.androidHackathonApp

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.kinandcarta.lib.find.meal.view.FindMealActivity

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        setTitle(R.string.app_name)

        val addMealButton = findViewById<ActionButton>(R.id.add_meal_button)
        addMealButton.setIcon(R.drawable.ic_outline_add_box_24)
        addMealButton.setText(R.string.add_meal_title)
        addMealButton.setOnClickListener {
            val intent = Intent(this, AddMealActivity::class.java)
            startActivity(intent)
        }

        val findMealButton = findViewById<ActionButton>(R.id.find_meal_button)
        findMealButton.setIcon(R.drawable.ic_baseline_search_24)
        findMealButton.setText(R.string.find_meal_title)
        findMealButton.setOnClickListener {
            val intent = Intent(this, FindMealActivity::class.java)
            startActivity(intent)
        }
    }
}
