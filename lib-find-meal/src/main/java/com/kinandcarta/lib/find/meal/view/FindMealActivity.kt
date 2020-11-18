package com.kinandcarta.lib.find.meal.view

import android.Manifest
import android.content.pm.PackageManager
import android.content.pm.PackageManager.PERMISSION_GRANTED
import android.location.Location
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.FrameLayout
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.core.view.isVisible
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationServices
import com.kcc.kmmhackathon.shared.MealsSDK
import com.kinandcarta.lib.find.meal.adapter.MealsAdapter
import com.kinandcarta.lib.find.meal.R
import kotlinx.coroutines.MainScope
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch

class FindMealActivity : AppCompatActivity() {
    private val mainScope = MainScope()
    private val sdk = MealsSDK()
    private val mealsAdapter = MealsAdapter(listOf())

    private lateinit var mealsRecyclerView: RecyclerView
    private lateinit var progressBarView: FrameLayout
    private lateinit var swipeRefreshLayout: SwipeRefreshLayout

    private lateinit var fusedLocationProviderClient: FusedLocationProviderClient
    private lateinit var lastLocation: Location

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        title = "Find a meal"
        setContentView(R.layout.find_meal_activity)

        fusedLocationProviderClient = LocationServices.getFusedLocationProviderClient(this)
        updateLastLocation()

        mealsRecyclerView = findViewById(R.id.rvMeals)
        progressBarView = findViewById(R.id.progressBar)
        swipeRefreshLayout = findViewById(R.id.swipeContainer)

        mealsRecyclerView.adapter = mealsAdapter
        mealsRecyclerView.layoutManager = LinearLayoutManager(this)

        swipeRefreshLayout.setOnRefreshListener {
            swipeRefreshLayout.isRefreshing = false
            displayMeals(true)
            updateLastLocation()
        }
        displayMeals(false)
    }

    private fun updateLastLocation() {
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) == PERMISSION_GRANTED) {
            fusedLocationProviderClient.lastLocation.addOnSuccessListener { location: Location ->
                if (location != null) {
                    lastLocation = location
                    Toast.makeText(this@FindMealActivity, "You current location is \n Lat: ${location.latitude} \n Lon: ${location.longitude}", Toast.LENGTH_LONG)
                        .show()
                }
            }
        } else {
            ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.ACCESS_FINE_LOCATION), LOCATION_PERMISSION_REQUEST_CODE)
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        mainScope.cancel() // TODO: We'd get this for free in a ViewModel?
    }

    private fun displayMeals(needReload: Boolean) {
        progressBarView.isVisible = true
        mainScope.launch {
            kotlin.runCatching {
                sdk.getMeals(needReload)
            }.onSuccess {
                mealsAdapter.mealsList = it
                mealsAdapter.notifyDataSetChanged()
            }.onFailure {
                Toast.makeText(this@FindMealActivity, it.localizedMessage, Toast.LENGTH_SHORT)
                    .show()
            }
            progressBarView.isVisible = false
        }
    }

    companion object {
        private const val LOCATION_PERMISSION_REQUEST_CODE = 1
    }
}
