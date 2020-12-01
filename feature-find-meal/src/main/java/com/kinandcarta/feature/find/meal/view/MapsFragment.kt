package com.kinandcarta.feature.find.meal.view

import android.annotation.SuppressLint
import android.content.Context
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.OnMapReadyCallback
import com.google.android.gms.maps.SupportMapFragment
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.MarkerOptions
import com.google.android.material.bottomsheet.BottomSheetBehavior
import com.google.android.material.floatingactionbutton.FloatingActionButton
import com.kcc.kmmhackathon.shared.utility.extensions.getPortionsString
import com.kinandcarta.feature.find.meal.R
import com.kinandcarta.feature.find.meal.extension.requestFineLocationPermission
import com.kinandcarta.feature.find.meal.extension.showToast
import com.kinandcarta.feature.find.meal.utility.PermissionResultParser
import com.kinandcarta.feature.find.meal.viewmodel.MapsViewModel
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class MapsFragment : Fragment() {

    private lateinit var map: GoogleMap
    private lateinit var fab: FloatingActionButton
    private val viewModel: MapsViewModel by viewModels()

    override fun onAttach(context: Context) {
        super.onAttach(context)
        requestFineLocationPermission(LOCATION_PERMISSION_REQUEST_CODE)
    }

    private val callback = OnMapReadyCallback { googleMap ->
        map = googleMap
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        val view: View = inflater.inflate(R.layout.fragment_maps, container, false)
        fab = view.findViewById(R.id.fab)

        val bottomSheet: View = view.findViewById(R.id.bottom_sheet)
        val behavior = BottomSheetBehavior.from(bottomSheet)

        behavior.addBottomSheetCallback(object : BottomSheetBehavior.BottomSheetCallback() {
            override fun onStateChanged(bottomSheet: View, newState: Int) {
                //TODO - finish this
            }

            override fun onSlide(bottomSheet: View, slideOffset: Float) {
                //TODO - finish this
            }
        })

        fab.setOnClickListener {
            behavior.state = BottomSheetBehavior.STATE_EXPANDED
        }

        return view
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
            map.isMyLocationEnabled = true
        } else {
            showToast("Location permissions are required to find meals")
        }
    }

    private fun setupUI() {
        val mapFragment = childFragmentManager.findFragmentById(R.id.map) as SupportMapFragment?
        mapFragment?.getMapAsync(callback)
    }

    private fun onStateChanged(state: MapsViewModel.State) {
        when (state) {
            MapsViewModel.State.LoadingMeals ->
                Log.i("Map view", "Loading meals")
            is MapsViewModel.State.LoadedMeals ->
                onLoadedMeals(state)
            is MapsViewModel.State.LocationUpdate ->
                onLocationUpdate(state)
            is MapsViewModel.State.Failed ->
                onFailure(state.failure)
        }
    }

    private fun onLocationUpdate(state: MapsViewModel.State.LocationUpdate) {
        map.moveCamera(CameraUpdateFactory.newLatLngZoom(state.userLatLng, 12.0f))
    }

    private fun onLoadedMeals(state: MapsViewModel.State.LoadedMeals) {
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

    private fun onFailure(failure: MapsViewModel.Failure) {
        when (failure) {
            is MapsViewModel.Failure.LoadingMealsFailed -> {
                showToast(failure.localizedMessage ?: "An unexpected error occurred loading meals")
            }
        }
    }

    companion object {
        private const val LOCATION_PERMISSION_REQUEST_CODE = 1
    }
}