package com.kcc.kmmhackathon.androidHackathonApp

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.FrameLayout
import android.widget.Toast
import androidx.core.view.isVisible
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import com.kcc.kmmhackathon.shared.MealsSDK
import com.kcc.kmmhackathon.shared.entity.Meal
import kotlinx.coroutines.MainScope
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch

class FindMealActivity : AppCompatActivity() {
    private val mainScope = MainScope()

    private lateinit var mealsRecyclerView: RecyclerView
    private lateinit var progressBarView: FrameLayout
    private lateinit var swipeRefreshLayout: SwipeRefreshLayout

    private val sdk = MealsSDK()
    private val mealsAdapter = MealsAdapter(listOf())

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        title = "Find a meal"
        setContentView(R.layout.find_meal_activity)

        mealsRecyclerView = findViewById(R.id.rvMeals)
        progressBarView = findViewById(R.id.progressBar)
        swipeRefreshLayout = findViewById(R.id.swipeContainer)

        mealsRecyclerView.adapter = mealsAdapter
        mealsRecyclerView.layoutManager = LinearLayoutManager(this)

        swipeRefreshLayout.setOnRefreshListener {
            swipeRefreshLayout.isRefreshing = false
            displayMeals(true)
        }
        displayMeals(false)
    }

    override fun onDestroy() {
        super.onDestroy()
        mainScope.cancel()
    }

    private fun displayMeals(needReload: Boolean) {
        Log.i("==DisplayMeals", "Inside fun")
        progressBarView.isVisible = true
        mainScope.launch {
            Log.i("==DisplayMeals", "Inside launch")
            kotlin.runCatching {
                sdk.getMeals(needReload)
            }.onSuccess {
                Log.i("DisplayMeals:", "Success ${it}")
                mealsAdapter.mealsList = it
                mealsAdapter.notifyDataSetChanged()
            }.onFailure {
                Log.i("DisplayMeals:", "Failure")
                Toast.makeText(this@FindMealActivity, it.localizedMessage, Toast.LENGTH_SHORT).show()
                loadSampleMeals()
            }
            progressBarView.isVisible = false
        }
    }

    private fun loadSampleMeals() {
        var lastMealId = 0
        var numMeals = 22

        val sampleMeals = ArrayList<Meal>()
        for (i in 1..numMeals) {
            sampleMeals.add(
                Meal(
                "${++lastMealId}",
                "Meal + ${lastMealId}",
                50 - i,
                "Today",
                "Saturday",
                "This is a great meal",
                i <= numMeals / 2,
                51.023f,
                0.21f)
            )
        }

        mealsAdapter.mealsList = sampleMeals
        mealsAdapter.notifyDataSetChanged()
    }
}