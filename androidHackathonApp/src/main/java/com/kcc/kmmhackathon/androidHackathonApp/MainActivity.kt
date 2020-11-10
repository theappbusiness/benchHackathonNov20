package com.kcc.kmmhackathon.androidHackathonApp

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

        val listMealButton = findViewById<ActionButton>(R.id.list_meal)
        listMealButton.setIcon(R.drawable.ic_baseline_search_24)
        listMealButton.setText(R.string.findButton)

        val addMealButton = findViewById<ActionButton>(R.id.add_meal)
        addMealButton.setIcon(R.drawable.ic_outline_add_box_24)
        addMealButton.setText(R.string.plusButton)

    }
}
