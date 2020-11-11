package com.kcc.kmmhackathon.androidHackathonApp

import android.content.Intent
import android.graphics.drawable.GradientDrawable
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.kcc.kmmhackathon.shared.Greeting
import android.widget.TextView

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        setTitle(R.string.heading)

        val addMealButton = findViewById<ActionButton>(R.id.add_meal_button)
        addMealButton.setIcon(R.drawable.ic_outline_add_box_24)
        addMealButton.setText(R.string.add_meal_title)
        addMealButton.setOnClickListener {
            println("Add meal button tapped")
            val intent = Intent(this, AddMealActivity::class.java)
            startActivity(intent)
        }

        val findMealButton = findViewById<ActionButton>(R.id.find_meal_button)
        findMealButton.setIcon(R.drawable.ic_baseline_search_24)
        findMealButton.setText(R.string.find_meal_title)
        findMealButton.setOnClickListener {
            println("Find meal button tapped")
            val intent = Intent(this, FindMealActivity::class.java)
            startActivity(intent)
        }
    }
}
