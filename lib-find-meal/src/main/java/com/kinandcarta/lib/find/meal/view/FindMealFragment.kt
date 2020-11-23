package com.kinandcarta.lib.find.meal.view

import android.content.Context
import android.location.Location
import androidx.lifecycle.ViewModelProvider
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import android.widget.Toast
import androidx.core.content.ContextCompat
import androidx.core.view.isVisible
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import com.google.android.gms.location.FusedLocationProviderClient
import com.kcc.kmmhackathon.shared.MealsSDK
import com.kinandcarta.lib.find.meal.R
import com.kinandcarta.lib.find.meal.adapter.MealsAdapter
import com.kinandcarta.lib.find.meal.viewmodel.FindMealViewModel
import kotlinx.coroutines.MainScope
import kotlinx.coroutines.launch
import android.Manifest
import android.content.pm.PackageManager
import com.kcc.kmmhackathon.shared.utility.DistanceUnit
import com.kinandcarta.lib.find.meal.utility.PermissionResultParser

class FindMealFragment : Fragment() {

    private val mainScope = MainScope()

    private lateinit var mealsRecyclerView: RecyclerView
    private lateinit var progressBarView: FrameLayout
    private lateinit var swipeRefreshLayout: SwipeRefreshLayout
    private var lastLocation: Location? = null

    private val sdk = MealsSDK()
    private var distanceUnit: DistanceUnit = DistanceUnit.miles
    private val mealsAdapter = MealsAdapter(listOf(), distanceUnit)

    private lateinit var fusedLocationClient: FusedLocationProviderClient
    private val permissionResultParser: PermissionResultParser by lazy { PermissionResultParser() }

    companion object {
        val LOCATION_PERMISSION_REQUEST_CODE = 1
        fun newInstance() = FindMealFragment()
    }

    private lateinit var viewModel: FindMealViewModel

    override fun onAttach(context: Context) {
        super.onAttach(context)
        confirmPermissions(context)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.find_meal_fragment, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        progressBarView = view.findViewById(R.id.progressBar)
        mealsRecyclerView = view.findViewById(R.id.rvMeals)
        swipeRefreshLayout = view.findViewById(R.id.swipeContainer)

        viewModel = ViewModelProvider(this).get(FindMealViewModel::class.java)

        fusedLocationClient = FusedLocationProviderClient(this.requireActivity())
        mealsRecyclerView.adapter = mealsAdapter
        mealsRecyclerView.layoutManager = LinearLayoutManager(context)

        swipeRefreshLayout.setOnRefreshListener {
            swipeRefreshLayout.isRefreshing = false
            getLastLocation()
        }

        getLastLocation()
    }

    private fun confirmPermissions(context: Context) {
        if (ContextCompat.checkSelfPermission(context, Manifest.permission.ACCESS_FINE_LOCATION) !== PackageManager.PERMISSION_GRANTED) {
            requestFineLocationPermission(LOCATION_PERMISSION_REQUEST_CODE)
        }
    }

    fun requestFineLocationPermission(requestCode: Int = 0) {
        requestPermissions(arrayOf(Manifest.permission.ACCESS_FINE_LOCATION), requestCode)
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        if (permissionResultParser.isFineLocationPermissionsGranted(permissions, grantResults)) {
            getLastLocation()
        } else {
            // TODO Ask user to update settings / location settings are required
        }
    }

    fun getLastLocation() {
        fusedLocationClient.lastLocation.addOnSuccessListener { location: Location? ->
            if (location != null) {
                lastLocation = location
                updateMeals(false)
            }
        }
    }

    private fun updateMeals(needReload: Boolean) {
        val location = lastLocation ?: return
        progressBarView.isVisible = true

        mainScope.launch {
            kotlin.runCatching {
                sdk.getSortedMeals(location.latitude, location.longitude, distanceUnit, needReload)
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