package com.kinandcarta.lib.find.meal.view

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.content.IntentSender
import android.content.pm.PackageManager.PERMISSION_GRANTED
import android.location.Location
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.FrameLayout
import androidx.core.app.ActivityCompat
import androidx.core.view.isVisible
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import com.google.android.gms.common.api.ResolvableApiException
import com.google.android.gms.location.*
import com.kcc.kmmhackathon.shared.MealsSDK
import com.kinandcarta.lib.find.meal.adapter.MealsAdapter
import com.kinandcarta.lib.find.meal.R
import com.kinandcarta.lib.find.meal.utility.PermissionResultParser
import kotlinx.coroutines.MainScope
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch

enum class DistanceUnit {
    kilometres,
    miles
}

class FindMealActivity : AppCompatActivity() {
    private val mainScope = MainScope()
    private val sdk = MealsSDK()
    private val mealsAdapter = MealsAdapter(listOf())

    private lateinit var mealsRecyclerView: RecyclerView
    private lateinit var progressBarView: FrameLayout
    private lateinit var swipeRefreshLayout: SwipeRefreshLayout
    private lateinit var locationRequest: LocationRequest

    private val fusedLocationProviderClient: FusedLocationProviderClient by lazy {
        LocationServices.getFusedLocationProviderClient(this)
    }

    private val permissionResultParser: PermissionResultParser by lazy { PermissionResultParser() }

    private var lastLocation: Location? = null

    private var locationUpdateState = false
    private val locationCallback = object : LocationCallback() {
        override fun onLocationResult(locationResult: LocationResult?) {
            val location = locationResult?.lastLocation ?: return
            lastLocation = location
        }
    }
    private var distanceUnit = DistanceUnit.miles

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(com.kinandcarta.lib.find.meal.R.layout.find_meal_activity)
        title = getString(R.string.find_meal_title)

        requestPermissions()

        mealsRecyclerView = findViewById(com.kinandcarta.lib.find.meal.R.id.rvMeals)
        progressBarView = findViewById(com.kinandcarta.lib.find.meal.R.id.progressBar)
        swipeRefreshLayout = findViewById(com.kinandcarta.lib.find.meal.R.id.swipeContainer)

        mealsRecyclerView.adapter = mealsAdapter
        mealsRecyclerView.layoutManager = LinearLayoutManager(this)

        swipeRefreshLayout.setOnRefreshListener {
            swipeRefreshLayout.isRefreshing = false
            displayMeals(true)
        }
    }

    private fun requestPermissions() {
        ActivityCompat.requestPermissions(
            this,
            arrayOf(Manifest.permission.ACCESS_FINE_LOCATION),
            LOCATION_PERMISSION_REQUEST_CODE
        )
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        if (permissionResultParser.isFineLocationPermissionsGranted(permissions, grantResults)) {
            updateLastLocation()
            createLocationRequest()
            startLocationUpdates()
        } else {
            // Ask user to update settings
        }
    }

    private fun updateLastLocation() {
        fusedLocationProviderClient.lastLocation.addOnSuccessListener { location: Location ->
            lastLocation = location
            displayMeals(false)
        }
    }

    private fun startLocationUpdates() {
        fusedLocationProviderClient.requestLocationUpdates(locationRequest, locationCallback, null)
    }

    private fun createLocationRequest() {
        locationRequest = LocationRequest()

        locationRequest.interval = 100000
        locationRequest.fastestInterval = 5000
        locationRequest.priority = LocationRequest.PRIORITY_HIGH_ACCURACY

        val builder = LocationSettingsRequest.Builder()
            .addLocationRequest(locationRequest)

        val client = LocationServices.getSettingsClient(this)
        val task = client.checkLocationSettings(builder.build())

        task.addOnSuccessListener {
            locationUpdateState = true
            startLocationUpdates()
        }
        task.addOnFailureListener { e ->
            if (e is ResolvableApiException) {
                try {
                    e.startResolutionForResult(this@FindMealActivity, REQUEST_CHECK_SETTINGS)
                } catch (sendEx: IntentSender.SendIntentException) {
                    // Ignore the error
                }
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == REQUEST_CHECK_SETTINGS) {
            if (resultCode == Activity.RESULT_OK) {
                locationUpdateState = true
                startLocationUpdates()
            }
        }
    }

    override fun onPause() {
        super.onPause()
        fusedLocationProviderClient.removeLocationUpdates((locationCallback))
    }

    override fun onResume() {
        super.onResume()
        if (!locationUpdateState) {
            startLocationUpdates()
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        mainScope.cancel() // TODO: We'd get this for free in a ViewModel?
    }

    private fun displayMeals(needReload: Boolean) {
        val location = lastLocation ?: return
        progressBarView.isVisible = true
        mainScope.launch {
            kotlin.runCatching {
                sdk.getMeals(location.latitude, location.longitude, distanceUnit.ordinal, needReload)
            }.onSuccess {
                mealsAdapter.mealsList = it
                mealsAdapter.notifyDataSetChanged()
            }.onFailure {
                // Handle error
            }
            progressBarView.isVisible = false
        }
    }

    companion object {
        private const val LOCATION_PERMISSION_REQUEST_CODE = 1
        private const val REQUEST_CHECK_SETTINGS = 2
    }
}
