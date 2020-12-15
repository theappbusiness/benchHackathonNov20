package com.kinandcarta.feature.find.meal.view

import android.Manifest
import android.annotation.SuppressLint
import android.content.pm.PackageManager
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import androidx.core.app.ActivityCompat
import androidx.core.view.isVisible
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.recyclerview.widget.RecyclerView
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.SupportMapFragment
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.MarkerOptions
import com.google.android.material.bottomsheet.BottomSheetBehavior
import com.kinandcarta.feature.find.meal.R
import com.kinandcarta.feature.find.meal.adapter.MealsAdapter
import com.kinandcarta.feature.find.meal.databinding.FindMealFragmentBinding
import com.kinandcarta.feature.find.meal.extension.getPortionsString
import com.kinandcarta.feature.find.meal.extension.requestFineLocationPermission
import com.kinandcarta.feature.find.meal.extension.showToast
import com.kinandcarta.feature.find.meal.ui.BottomSheetBehaviourCallback
import com.kinandcarta.feature.find.meal.utility.PermissionResultParser
import com.kinandcarta.feature.find.meal.viewmodel.DisplayMealsViewModel
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class FindMealFragment : Fragment() {

    private val viewModel: DisplayMealsViewModel by viewModels()

    private var _binding: FindMealFragmentBinding? = null
    private val binding get() = _binding!!

    private lateinit var userLatLng: LatLng
    private lateinit var map: GoogleMap

    private val progressBarView: FrameLayout by lazy { binding.progressBar }
    private val mealsRecyclerView: RecyclerView by lazy { binding.rvMeals }
    private val mealsAdapter = MealsAdapter { id -> viewModel.reserveAMeal(id) }

    private val behaviourCallback by lazy { BottomSheetBehaviourCallback() }

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

        setupUI()

        if (ActivityCompat.checkSelfPermission(
                requireContext(),
                Manifest.permission.ACCESS_FINE_LOCATION
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            requestFineLocationPermission(LOCATION_PERMISSION_REQUEST_CODE)
            return
        }
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
            map.isMyLocationEnabled = true
        } else {
            showToast("Location permissions are required to find meals")
        }
    }

    private fun setupUI() {
        mealsRecyclerView.adapter = mealsAdapter

        val mapFragment = childFragmentManager.findFragmentById(R.id.map) as SupportMapFragment?
        mapFragment?.getMapAsync { googleMap ->
            map = googleMap
            requestFineLocationPermission(LOCATION_PERMISSION_REQUEST_CODE)
        }

        behaviourCallback.setup(::onBottomSheetCollapsed, ::onBottomSheetExpanded)
        BottomSheetBehavior.from(binding.listBottomSheet).addBottomSheetCallback(behaviourCallback)
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
            is DisplayMealsViewModel.State.LocationUpdate ->
                onLocationUpdate(state)
            is DisplayMealsViewModel.State.Failed ->
                onFailure(state.failure)
        }
    }

    private fun onLoadedMeals(state: DisplayMealsViewModel.State.LoadedMeals) {
        progressBarView.isVisible = false
        mealsAdapter.submitList(state.meals)

        state.meals.forEach {
            placeMarkerOnMap(
                LatLng(it.locationLat.toDouble(), it.locationLong.toDouble()),
                it.name,
                it.quantity.getPortionsString()
            )
        }
    }

    private fun placeMarkerOnMap(location: LatLng, title: String, mealsRemaining: String) {
        val markerOptions = MarkerOptions().position(location).title(title).snippet(mealsRemaining)
        map.addMarker(markerOptions)
    }

    private fun onReservedMeal(state: DisplayMealsViewModel.State.ReservedMeal) {
        viewModel.updateMeals(userLatLng)
        showToast("${getString(R.string.reservation_message)} ${state.code}")
    }

    private fun onMealUnavailable(state: DisplayMealsViewModel.State.MealUnavailable) {
        showToast(getString(R.string.meal_unavailable_message))
    }

    private fun onLocationUpdate(state: DisplayMealsViewModel.State.LocationUpdate) {
        userLatLng = state.userLatLng
        map.moveCamera(CameraUpdateFactory.newLatLngZoom(state.userLatLng, 12.0f))
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

    private fun onBottomSheetCollapsed() {
        binding.bottomSheetTitle.text = getString(R.string.title_show_list)
    }

    private fun onBottomSheetExpanded() {
        binding.bottomSheetTitle.text = getString(R.string.title_hide_list)
    }

    companion object {
        private const val LOCATION_PERMISSION_REQUEST_CODE = 1
    }
}
