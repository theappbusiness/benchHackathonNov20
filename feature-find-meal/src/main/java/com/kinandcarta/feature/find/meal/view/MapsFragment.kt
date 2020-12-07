package com.kinandcarta.feature.find.meal.view

import android.annotation.SuppressLint
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.OnMapReadyCallback
import com.google.android.gms.maps.SupportMapFragment
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.MarkerOptions
import com.google.android.material.bottomsheet.BottomSheetBehavior
import com.kinandcarta.feature.find.meal.R
import com.kinandcarta.feature.find.meal.extension.getPortionsString
import com.kinandcarta.feature.find.meal.extension.requestFineLocationPermission
import com.kinandcarta.feature.find.meal.extension.showToast
import com.kinandcarta.feature.find.meal.utility.PermissionResultParser
import com.kinandcarta.feature.find.meal.viewmodel.DisplayMealsViewModel
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class MapsFragment : Fragment() {

    private lateinit var map: GoogleMap
    private val viewModel: DisplayMealsViewModel by viewModels()
    private lateinit var bottomSheetBehavior: BottomSheetBehavior<*>

    private val callback = OnMapReadyCallback { googleMap ->
        map = googleMap
        requestFineLocationPermission(LOCATION_PERMISSION_REQUEST_CODE)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view: View = inflater.inflate(R.layout.fragment_maps, container, false)
        setupUI()
        bottomSheetBehavior = BottomSheetBehavior.from(view.findViewById(R.id.list_bottomSheet))
        bottomSheetBehavior.addBottomSheetCallback(object :
            BottomSheetBehavior.BottomSheetCallback() {

            override fun onSlide(bottomSheet: View, slideOffset: Float) {
                // handle onSlide
            }

            override fun onStateChanged(bottomSheet: View, newState: Int) =
                when (newState) {
                    BottomSheetBehavior.STATE_COLLAPSED -> Toast.makeText(context, "STATE_COLLAPSED", Toast.LENGTH_SHORT).show()
                    BottomSheetBehavior.STATE_EXPANDED -> Toast.makeText(context, "STATE_EXPANDED", Toast.LENGTH_SHORT).show()
                    BottomSheetBehavior.STATE_DRAGGING -> Toast.makeText(context, "STATE_DRAGGING", Toast.LENGTH_SHORT).show()
                    BottomSheetBehavior.STATE_SETTLING -> Toast.makeText(context, "STATE_SETTLING", Toast.LENGTH_SHORT).show()
                    BottomSheetBehavior.STATE_HIDDEN -> Toast.makeText(context, "STATE_HIDDEN", Toast.LENGTH_SHORT).show()
                    else -> Toast.makeText(context, "OTHER_STATE", Toast.LENGTH_SHORT).show()
                }
            })


        return view
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
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
            map.isMyLocationEnabled = true

        } else {
            showToast("Location permissions are required to find meals")
        }
    }

    private fun setupUI() {
        val mapFragment = childFragmentManager.findFragmentById(R.id.map) as SupportMapFragment?
        mapFragment?.getMapAsync(callback)
    }

    private fun onStateChanged(state: DisplayMealsViewModel.State) {
        when (state) {
            DisplayMealsViewModel.State.LoadingMeals ->
                Log.i("Map view", "Loading meals")
            is DisplayMealsViewModel.State.LoadedMeals ->
                onLoadedMeals(state)
            is DisplayMealsViewModel.State.LocationUpdate ->
                onLocationUpdate(state)
            is DisplayMealsViewModel.State.Failed ->
                onFailure(state.failure)
        }
    }

    private fun onLocationUpdate(state: DisplayMealsViewModel.State.LocationUpdate) {
        map.moveCamera(CameraUpdateFactory.newLatLngZoom(state.userLatLng, 12.0f))
    }

    private fun onLoadedMeals(state: DisplayMealsViewModel.State.LoadedMeals) {
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

    private fun onFailure(failure: DisplayMealsViewModel.Failure) {
        when (failure) {
            is DisplayMealsViewModel.Failure.LoadingMealsFailed -> {
                showToast(failure.localizedMessage ?: "An unexpected error occurred loading meals")
            }
        }
    }

    companion object {
        private const val LOCATION_PERMISSION_REQUEST_CODE = 1
    }
}