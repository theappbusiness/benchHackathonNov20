package com.kinandcarta.feature.find.meal.view

import android.annotation.SuppressLint
import android.content.Context
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.OnMapReadyCallback
import com.google.android.gms.maps.SupportMapFragment
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.MarkerOptions
import com.google.android.material.bottomsheet.BottomSheetBehavior
import com.kcc.kmmhackathon.shared.utility.extensions.getPortionsString
import com.kinandcarta.feature.find.meal.R
import com.kinandcarta.feature.find.meal.adapter.MealsAdapter
import com.kinandcarta.feature.find.meal.extension.requestFineLocationPermission
import com.kinandcarta.feature.find.meal.extension.showToast
import com.kinandcarta.feature.find.meal.utility.PermissionResultParser
import com.kinandcarta.feature.find.meal.viewmodel.FindMealViewModel
import com.kinandcarta.feature.find.meal.viewmodel.MapsViewModel
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class MapsFragment : Fragment() {

    private lateinit var map: GoogleMap
    private val mapsViewModel: MapsViewModel by viewModels()
    private val viewModel: FindMealViewModel by viewModels()
    private lateinit var bottomSheetBehavior: BottomSheetBehavior<*>
    private val mealsAdapter = MealsAdapter { id, position -> viewModel.reserveAMeal(id, position) }

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
        setupUI()
        mapsViewModel.state.observe(viewLifecycleOwner, ::onStateChanged)
    }

    @SuppressLint("MissingPermission")
    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        val permissionResultParser = PermissionResultParser()
        if (permissionResultParser.isFineLocationPermissionsGranted(permissions, grantResults)) {
            mapsViewModel.startUpdatingLocation()
            map.isMyLocationEnabled = true
        } else {
            showToast("Location permissions are required to find meals")
        }
    }

    private fun setupUI() {
        val mapFragment = childFragmentManager.findFragmentById(R.id.map) as SupportMapFragment?
        mapFragment?.getMapAsync(callback)

        //Recycler view and adapter for the bottom sheet
        val rv: RecyclerView = requireView().findViewById(R.id.rvMeals)
        rv.layoutManager = LinearLayoutManager(context)
        rv.adapter = mealsAdapter
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