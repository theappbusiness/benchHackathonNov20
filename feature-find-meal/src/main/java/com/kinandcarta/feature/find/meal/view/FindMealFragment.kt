package com.kinandcarta.feature.find.meal.view

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import androidx.core.view.isVisible
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.kinandcarta.feature.find.meal.R
import com.kinandcarta.feature.find.meal.adapter.MealsAdapter
import com.kinandcarta.feature.find.meal.databinding.FindMealFragmentBinding
import com.kinandcarta.feature.find.meal.extension.showToast
import com.kinandcarta.feature.find.meal.viewmodel.DisplayMealsViewModel
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class FindMealFragment : Fragment() {

    private val progressBarView: FrameLayout by lazy { binding.progressBar }
    private val viewModel: DisplayMealsViewModel by viewModels()
    private val mealsRecyclerView: RecyclerView by lazy { binding.rvMeals }
    private val mealsAdapter = MealsAdapter { id -> viewModel.reserveAMeal(id) }
    private var _binding: FindMealFragmentBinding? = null
    private val binding get() = _binding!!

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        _binding = FindMealFragmentBinding.inflate(inflater, container, false)

        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        viewModel.state.observe(viewLifecycleOwner, ::onStateChanged)
        setupRecyclerView()
        viewModel.startUpdatingLocation()
    }

    fun setupRecyclerView() {
        mealsRecyclerView.apply {
            adapter = mealsAdapter
            layoutManager = LinearLayoutManager(context)
        }
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
    }

    private fun onReservedMeal(state: DisplayMealsViewModel.State.ReservedMeal) {
        showToast("${getString(R.string.reservation_message)} ${state.code}")
    }

    private fun onMealUnavailable(state: DisplayMealsViewModel.State.MealUnavailable) {
        showToast(getString(R.string.meal_unavailable_message))
    }

    private fun onFailure(failure: DisplayMealsViewModel.Failure) {
        when (failure) {
            is DisplayMealsViewModel.Failure.LoadingMealsFailed -> {
                progressBarView.isVisible = false
                showToast(failure.localizedMessage ?: getString(R.string.error_loading_meals))
            }
            is DisplayMealsViewModel.Failure.ReserveAMealFailed -> {
                showToast(
                    failure.localizedMessage ?: getString(R.string.error_reserving_meal)
                )
            }
        }
    }

    companion object {
        val newInstance = FindMealFragment()
    }
}
