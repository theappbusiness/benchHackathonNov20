package com.kcc.kmmhackathon.androidHackathonApp.view

import android.annotation.SuppressLint
import android.content.Context
import android.location.Location
import android.os.Bundle
import android.util.Log
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
        requestFineLocationPermission(LOCATION_PERMISSION_REQUEST_CODE)
    }

    private val callback = OnMapReadyCallback { googleMap ->
        /**
         * Manipulates the map once available.
         * This callback is triggered when the map is ready to be used.
         * This is where we can add markers or lines, add listeners or move the camera.
         * In this case, we just add a marker near Sydney, Australia.
         * If Google Play services is not installed on the device, the user will be prompted to
         * install it inside the SupportMapFragment. This method will only be triggered once the
         * user has installed Google Play services and returned to the app.
         */
        map = googleMap
//        val kinAndCarta = LatLng(51.5320, -0.1189)
//        googleMap.addMarker(MarkerOptions().position(kinAndCarta).title("Kin+Carta Create"))
//        googleMap.moveCamera(CameraUpdateFactory.newLatLngZoom(kinAndCarta, 16.0f))
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
            is MapsViewModel.State.Failed ->
                onFailure(state.failure)
        }
    }

    private fun onLoadedMeals(state: MapsViewModel.State.LoadedMeals) {
        Log.i("Maps", "Meals to display ${state.meals}") // TODO: Display markers
        placeMarkerOnMap(state.userLocation, "My location")

        state.meals.forEach {
            placeMarkerOnMap(LatLng(it.locationLat.toDouble(), it.locationLong.toDouble()), it.name)
        }

        map.moveCamera(CameraUpdateFactory.newLatLngZoom(state.userLocation, 10.0f))
    }

    private fun placeMarkerOnMap(location: LatLng, title: String) {
        val markerOptions = MarkerOptions().position(location).title(title)
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