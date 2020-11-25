package com.kinandcarta.lib.find.meal.viewmodel

import android.location.Location
import androidx.annotation.RequiresPermission
import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationCallback
import com.google.android.gms.location.LocationRequest
import com.google.android.gms.location.LocationResult
import com.kcc.kmmhackathon.shared.MealsSDK
import com.kcc.kmmhackathon.shared.entity.Meal
import com.kcc.kmmhackathon.shared.utility.DistanceUnit
import kotlinx.coroutines.launch

typealias Meals = List<Meal>

class FindMealViewModel @ViewModelInject constructor(
    private val fusedLocationClient: FusedLocationProviderClient
) : ViewModel() {

    sealed class State {
        object LoadingMeals : State()
        data class LoadedMeals(val meals: Meals, val distanceUnit: DistanceUnit) : State()
        data class Failed(val failure: Failure) : State()
    }

    sealed class Failure(cause: Throwable) : Throwable(cause) {
        class LoadingMealsFailed(cause: Throwable) : Failure(cause)
    }

    val state: LiveData<State> get() = _state

    private val _state: MutableLiveData<State> = MutableLiveData(State.LoadingMeals)
    private var lastLocation: Location? = null
    private val sdk = MealsSDK()
    private val locationCallback = object : LocationCallback() {
        override fun onLocationResult(locationResult: LocationResult?) {
            lastLocation = locationResult?.lastLocation
            updateMeals()
        }
    }

    override fun onCleared() {
        fusedLocationClient.removeLocationUpdates(locationCallback)
    }

    @RequiresPermission("android.permission.ACCESS_FINE_LOCATION")
    fun startUpdatingLocation() {
        fusedLocationClient.lastLocation.addOnSuccessListener {
            lastLocation = it
            updateMeals()
        }
        fusedLocationClient.requestLocationUpdates(
            createLocationRequest(),
            locationCallback,
            null
        )
    }

    fun updateMeals() {
        val location = lastLocation ?: return
        val distanceUnit = DistanceUnit.miles
        _state.value = State.LoadingMeals
        viewModelScope.launch {
            kotlin.runCatching {
                sdk.getSortedMeals(location.latitude, location.longitude, distanceUnit)
            }.onSuccess {
                _state.value = State.LoadedMeals(it, distanceUnit)
            }.onFailure {
                _state.value = State.Failed(Failure.LoadingMealsFailed(it))
            }
        }
    }

    private fun createLocationRequest(): LocationRequest {
        val locationRequest = LocationRequest()
        locationRequest.interval = 100000
        locationRequest.fastestInterval = 5000
        locationRequest.priority = LocationRequest.PRIORITY_HIGH_ACCURACY
        return locationRequest
    }
}