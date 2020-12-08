package com.kinandcarta.feature.find.meal.viewmodel

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
import com.google.android.gms.maps.model.LatLng
import com.kcc.kmmhackathon.shared.MealsSDK
import com.kcc.kmmhackathon.shared.entity.Meal
import com.kcc.kmmhackathon.shared.utility.DistanceUnit
import kotlinx.coroutines.launch

typealias Meals = List<Meal>

class DisplayMealsViewModel @ViewModelInject constructor(
    private val fusedLocationProviderClient: FusedLocationProviderClient
) : ViewModel() {

    sealed class State {
        object LoadingMeals : State()
        data class LoadedMeals(val meals: Meals, val distanceUnit: DistanceUnit) : State()
        data class ReservedMeal(val code: String, val position: Int) : State()
        data class LocationUpdate(val userLatLng: LatLng) : State()
        data class MealUnavailable(val code: String) : State()
        data class Failed(val failure: Failure) : State()
    }

    sealed class Failure(cause: Throwable) : Throwable(cause) {
        class LoadingMealsFailed(cause: Throwable) : Failure(cause)
        class ReserveAMealFailed(cause: Throwable) : Failure(cause)
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
        fusedLocationProviderClient.removeLocationUpdates(locationCallback)
    }

    @RequiresPermission("android.permission.ACCESS_FINE_LOCATION")
    fun startUpdatingLocation() {
        fusedLocationProviderClient.lastLocation.addOnSuccessListener {
            if (it != lastLocation) {
                lastLocation = it
                updateUserLocation()
            }
            updateMeals()
        }
        fusedLocationProviderClient.requestLocationUpdates(
            createLocationRequest(),
            locationCallback,
            null
        )
    }

    private fun createLocationRequest() = LocationRequest().apply {
        interval = ONE_MIN_40S_MS
        fastestInterval = FIVE_SEC_MS
        priority = LocationRequest.PRIORITY_HIGH_ACCURACY
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

    fun reserveAMeal(id: String, position: Int) {
        viewModelScope.launch {
            kotlin.runCatching {
                sdk.reserveMeal(id)
            }.onSuccess {
                if (it != null) {
                    val code = getReservationCode(it.id)
                    _state.value = State.ReservedMeal(code, position)
                } else {
                    _state.value = State.MealUnavailable("Meal Unavailable")
                }
            }.onFailure {
                _state.value = State.Failed(Failure.ReserveAMealFailed(it))
            }
        }
    }

    private fun updateUserLocation() {
        val location = lastLocation ?: return
        _state.value = State.LocationUpdate(LatLng(location.latitude, location.longitude))
    }

    private fun getReservationCode(id: String): String {
        return id.substring(id.length - 4, id.length)
    }

    companion object {
        private const val ONE_MIN_40S_MS: Long = 10000
        private const val FIVE_SEC_MS: Long = 5000
    }
}
