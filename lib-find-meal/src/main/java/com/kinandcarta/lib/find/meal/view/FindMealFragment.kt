package com.kinandcarta.lib.find.meal.view

import android.annotation.SuppressLint
import android.content.Context
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
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import com.kinandcarta.lib.find.meal.R
import com.kinandcarta.lib.find.meal.adapter.MealsAdapter
import com.kinandcarta.lib.find.meal.extension.requestFineLocationPermission
import com.kinandcarta.lib.find.meal.extension.showToast
import com.kinandcarta.lib.find.meal.utility.PermissionResultParser
import com.kinandcarta.lib.find.meal.viewmodel.FindMealViewModel
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class FindMealFragment : Fragment() {

    private val progressBarView: FrameLayout by lazy { requireView().findViewById(R.id.progressBar) }
    private val viewModel: FindMealViewModel by viewModels()
    private val mealsAdapter = MealsAdapter()

    override fun onAttach(context: Context) {
        super.onAttach(context)
        requestFineLocationPermission(LOCATION_PERMISSION_REQUEST_CODE)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.find_meal_fragment, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        setupUI()
        viewModel.state.observe(viewLifecycleOwner, ::onStateChanged)
    }

    @SuppressLint("MissingPermission")
    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        val permissionResultParser = PermissionResultParser()
        if (permissionResultParser.isFineLocationPermissionsGranted(permissions, grantResults)) {
            viewModel.startUpdatingLocation()
        } else {
            showToast("Location permissions are required to find meals")
        }
    }

    private fun setupUI() {
        val mealsRecyclerView: RecyclerView = requireView().findViewById(R.id.rvMeals)
        mealsRecyclerView.adapter = mealsAdapter
        mealsRecyclerView.layoutManager = LinearLayoutManager(context)
        val swipeRefreshLayout: SwipeRefreshLayout = requireView().findViewById(R.id.swipeContainer)
        swipeRefreshLayout.setOnRefreshListener {
            swipeRefreshLayout.isRefreshing = false
            viewModel.updateMeals()
        }
    }

    private fun onStateChanged(state: FindMealViewModel.State) {
        when (state) {
            FindMealViewModel.State.LoadingMeals ->
                progressBarView.isVisible = true
            is FindMealViewModel.State.LoadedMeals ->
                onLoadedMeals(state)
            is FindMealViewModel.State.Failed ->
                onFailure(state.failure)
        }
    }

    private fun onLoadedMeals(state: FindMealViewModel.State.LoadedMeals) {
        progressBarView.isVisible = false
        mealsAdapter.submit(state.meals, state.distanceUnit)
    }

    private fun onFailure(failure: FindMealViewModel.Failure) {
        when (failure) {
            is FindMealViewModel.Failure.LoadingMealsFailed -> {
                progressBarView.isVisible = false
                showToast(failure.localizedMessage ?: "An unexpected error occurred loading meals")
            }
        }
    }

    companion object {
        private const val LOCATION_PERMISSION_REQUEST_CODE = 1
    }
}