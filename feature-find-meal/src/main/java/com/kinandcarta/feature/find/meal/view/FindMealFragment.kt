package com.kinandcarta.feature.find.meal.view

import android.app.Dialog
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import androidx.coordinatorlayout.widget.CoordinatorLayout
import androidx.core.view.get
import androidx.core.view.isEmpty
import androidx.core.view.isVisible
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import com.kinandcarta.feature.find.meal.R
import com.kinandcarta.feature.find.meal.adapter.MealsAdapter
import com.kinandcarta.feature.find.meal.extension.showToast
import com.kinandcarta.feature.find.meal.viewmodel.DisplayMealsViewModel
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class FindMealFragment : Fragment() {

    private val progressBarView: FrameLayout by lazy { requireView().findViewById(R.id.progressBar) }
    private val viewModel: DisplayMealsViewModel by viewModels()
    private lateinit var mealsRecyclerView: RecyclerView
    private val mealsAdapter = MealsAdapter { id, position -> viewModel.reserveAMeal(id, position) }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        val view: View = inflater.inflate(R.layout.find_meal_fragment, container, false)
        mealsRecyclerView = view.findViewById(R.id.rvMeals)
        mealsRecyclerView.adapter = mealsAdapter
        mealsRecyclerView.layoutManager = LinearLayoutManager(context)
        println("hit oncv")

        return view
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        viewModel.state.observe(viewLifecycleOwner, ::onStateChanged)
        setupUI()
        println("hit onvc")
    }

    fun setupUI() {
        viewModel.startUpdatingLocation()
        println("hit setupUI")
        if (mealsRecyclerView.isEmpty()) println("recycler empty") else println("${mealsRecyclerView[0]}")
    }

    private fun onStateChanged(state: DisplayMealsViewModel.State) {
        when (state) {
            DisplayMealsViewModel.State.LoadingMeals ->
                progressBarView.isVisible = true
            is DisplayMealsViewModel.State.LoadedMeals ->
                onLoadedMeals(state)
            is DisplayMealsViewModel.State.ReservedMeal ->
                onReservedMeal(state)
            is DisplayMealsViewModel.State.MealUnavailable ->
                onMealUnavailable(state)
            is DisplayMealsViewModel.State.Failed ->
                onFailure(state.failure)
        }
    }

    private fun onLoadedMeals(state: DisplayMealsViewModel.State.LoadedMeals) {
        progressBarView.isVisible = false
        mealsAdapter.submitList(state.meals)
        Log.i("Find meal fragment", "onLoadedMeals ${state.meals}")
    }

    private fun onReservedMeal(state: DisplayMealsViewModel.State.ReservedMeal) {
        showToast("Your meal reservation code is ${state.code}")
    }

    private fun onMealUnavailable(state: DisplayMealsViewModel.State.MealUnavailable) {
        showToast("Unfortunately this meal is unavailable")
    }

    private fun onFailure(failure: DisplayMealsViewModel.Failure) {
        when (failure) {
            is DisplayMealsViewModel.Failure.LoadingMealsFailed -> {
                progressBarView.isVisible = false
                showToast(failure.localizedMessage ?: "An unexpected error occurred loading meals")
            }
            is DisplayMealsViewModel.Failure.ReserveAMealFailed -> {
                showToast(
                    failure.localizedMessage ?: "An unexpected error occurred reserving a meal"
                )
            }
        }
    }

    companion object {
        val newInstance = FindMealFragment()
    }
}
