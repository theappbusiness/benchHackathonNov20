package com.kinandcarta.lib.add.meal.viewmodel

import android.location.Location
import android.location.LocationManager
import androidx.compose.runtime.setValue
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.kcc.kmmhackathon.shared.MealsSDK
import com.kcc.kmmhackathon.shared.entity.Meal
import kotlinx.coroutines.launch
import java.time.LocalDateTime

data class MealForm constructor(
    var title: String = "",
    var additionalInformation: String = "",
    var quantity: String = "",
    var isHot: Boolean = true,
    var availableFrom: LocalDateTime = LocalDateTime.now(),
    var useBy: LocalDateTime = LocalDateTime.now(),
    var address: String = "",
    var location: Location = Location(LocationManager.GPS_PROVIDER)
)

class AddMealViewModel : ViewModel() {
    sealed class State() {
        object Initial: State()
        object Loading: State()
        object Success: State()
        object Failed: State()
    }

    var state: State by mutableStateOf(State.Initial)
        private set

    var meal: MealForm by mutableStateOf(MealForm())
        private set

    private var mealsSDK: MealsSDK

    init {
        this.mealsSDK = MealsSDK()
    }

    fun onEditTitle(newValue: String) {
        meal.title = newValue
    }

    fun onEditAdditionalInformation(newValue: String) {
        meal.additionalInformation = newValue
    }

    fun onEditQuantity(newValue: String) {
        meal.quantity = newValue
    }

    fun onEditTemperature(newValue: Boolean) {
        meal.isHot = newValue
    }

    fun onEditAvailableFrom(newValue: LocalDateTime) {
        meal.availableFrom = newValue
    }

    fun onEditUseBy(newValue: LocalDateTime) {
        meal.useBy = newValue
    }

    fun onEditAddress(newValue: String) {
        meal.address = newValue
    }

    fun onSubmit() {
        state = State.Loading
        viewModelScope.launch {
            kotlin.runCatching {
                val meal = Meal(
                    id = mealsSDK.getUUID().toString(),
                    name = meal.title,
                    info = meal.additionalInformation,
                    quantity = meal.quantity.toInt(),
                    availableFromDate = meal.availableFrom.toString() ,
                    expiryDate = meal.useBy.toString(),
                    hot = meal.isHot,
                    locationLat = meal.location.latitude.toFloat(),
                    locationLong = meal.location.longitude.toFloat(),
                    distance = null
                )
                mealsSDK.postMeal(meal = meal)
            }.onSuccess {
                meal = MealForm()
                state = State.Success
            }.onFailure {
                state = State.Failed
            }
        }
    }

}