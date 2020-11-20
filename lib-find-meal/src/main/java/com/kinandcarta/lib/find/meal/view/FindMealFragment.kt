package com.kinandcarta.lib.find.meal.view

import androidx.lifecycle.ViewModelProvider
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import android.widget.Toast
import androidx.core.view.isVisible
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import com.kcc.kmmhackathon.shared.MealsSDK
import com.kinandcarta.lib.find.meal.R
import com.kinandcarta.lib.find.meal.adapter.MealsAdapter
import com.kinandcarta.lib.find.meal.viewmodel.FindMealViewModel
import kotlinx.coroutines.MainScope
import kotlinx.coroutines.launch

class FindMealFragment : Fragment() {

    private val mainScope = MainScope()

    private lateinit var mealsRecyclerView: RecyclerView
    private lateinit var progressBarView: FrameLayout
    private lateinit var swipeRefreshLayout: SwipeRefreshLayout

    private val sdk = MealsSDK()
    private val mealsAdapter = MealsAdapter(listOf())

    companion object {
        fun newInstance() = FindMealFragment()
    }

    private lateinit var viewModel: FindMealViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        val view: View = inflater.inflate(R.layout.find_meal_fragment, container, false)

        progressBarView = view.findViewById(R.id.progressBar)
        mealsRecyclerView = view.findViewById(R.id.rvMeals)
        mealsRecyclerView.adapter = mealsAdapter
        mealsRecyclerView.layoutManager = LinearLayoutManager(context)

        swipeRefreshLayout = view.findViewById(R.id.swipeContainer)
        swipeRefreshLayout.setOnRefreshListener {
            swipeRefreshLayout.isRefreshing = false
            displayMeals(true)
        }

        displayMeals(false)

        return view
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        viewModel = ViewModelProvider(this).get(FindMealViewModel::class.java)
        // TODO: Use the ViewModel
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
                Toast.makeText(context, it.localizedMessage, Toast.LENGTH_SHORT)
                    .show()
            }
            progressBarView.isVisible = false
        }
    }
}