package com.kinandcarta.lib.find.meal

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.FrameLayout
import android.widget.Toast
import androidx.core.view.isVisible
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import com.kcc.kmmhackathon.shared.MealsSDK
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
        mainScope.cancel() // TODO: We'd get this for free in a ViewModel?
    }

    private fun displayMeals(needReload: Boolean) {
        progressBarView.isVisible = true
        mainScope.launch {
            kotlin.runCatching {
                sdk.getMeals(needReload)
            }.onSuccess {
                mealsAdapter.mealsList = it
                mealsAdapter.notifyDataSetChanged()
            }.onFailure {
                Toast.makeText(this@FindMealActivity, it.localizedMessage, Toast.LENGTH_SHORT)
                    .show()
            }
            progressBarView.isVisible = false
        }
    }
}
