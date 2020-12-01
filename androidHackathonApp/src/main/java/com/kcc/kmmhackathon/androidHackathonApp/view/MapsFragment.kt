package com.kcc.kmmhackathon.androidHackathonApp.view

import android.annotation.SuppressLint
import android.content.Context
import android.os.Bundle
import android.view.*
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.OnMapReadyCallback
import com.google.android.gms.maps.SupportMapFragment
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.MarkerOptions
import com.kcc.kmmhackathon.androidHackathonApp.R
import com.kcc.kmmhackathon.androidHackathonApp.viewmodel.MapsViewModel
import com.kinandcarta.feature.find.meal.extension.getPortionsString
import com.kinandcarta.feature.find.meal.extension.requestFineLocationPermission
import com.kinandcarta.feature.find.meal.extension.showToast
import com.kinandcarta.feature.find.meal.utility.PermissionResultParser
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class MapsFragment : Fragment() {

    private lateinit var map: GoogleMap
    private val viewModel: MapsViewModel by viewModels()

    override fun onAttach(context: Context) {
        super.onAttach(context)
    }

    private val callback = OnMapReadyCallback { googleMap ->
        map = googleMap
        requestFineLocationPermission(LOCATION_PERMISSION_REQUEST_CODE)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_maps, container, false)
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
            is MapsViewModel.State.LoadedMeals ->
                onLoadedMeals(state)
            is MapsViewModel.State.LocationUpdate ->
                onLocationUpdate(state)
            is MapsViewModel.State.Failed ->
                onFailure(state.failure)
            else -> return
        }
    }

    private fun onLocationUpdate(state: MapsViewModel.State.LocationUpdate) {
        map.moveCamera(CameraUpdateFactory.newLatLngZoom(state.userLatLng, 12.0f))
    }

    private fun onLoadedMeals(state: MapsViewModel.State.LoadedMeals) {
        state.meals.forEach {
            val snippet = "${it.quantity.getPortionsString()} (${it.distance} ${state.distanceUnit})"
            placeMarkerOnMap(LatLng(it.locationLat.toDouble(), it.locationLong.toDouble()), it.name, snippet)
        }
    }

    private fun placeMarkerOnMap(location: LatLng, title: String, snippet: String) {
        val markerOptions = MarkerOptions().position(location).title(title).snippet(snippet)
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