package com.kcc.kmmhackathon.androidHackathonApp

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.kcc.kmmhackathon.androidHackathonApp.data.Meal

class FindMealActivity : AppCompatActivity() {
    lateinit var mealsList : ArrayList<Meal>

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.find_meal_activity)

        val rvMeals = findViewById<View>(R.id.rvMeals) as RecyclerView
        mealsList = Meal.createMealList(15)
        val adapter = MealsAdapter(mealsList)

        rvMeals.adapter = adapter

        rvMeals.layoutManager = LinearLayoutManager(this)
    }
}