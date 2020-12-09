package com.kinandcarta.lib.add.meal.viewmodel

import android.location.*
import androidx.compose.runtime.setValue
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.kcc.kmmhackathon.shared.MealsSDK
import com.kcc.kmmhackathon.shared.entity.Meal
import com.kinandcarta.lib.add.meal.network.MealSDKRepository
import com.kinandcarta.lib.add.meal.network.MealsSDKRepositoryImpl
import kotlinx.coroutines.launch
import java.sql.Timestamp
import java.time.LocalDate
import java.time.ZoneOffset
import java.time.temporal.TemporalField

data class MealForm constructor(
    var title: String = "",
    var additionalInformation: String = "",
    var quantity: String = "",
    var isHot: Boolean = true,
    var availableFrom: LocalDate? = null,
    var useBy: LocalDate? = null,
    var address: String = "",
    var location: Location = Location(LocationManager.GPS_PROVIDER)
)

class AddMealViewModel(mealSDKRepository: MealSDKRepository = MealsSDKRepositoryImpl(mealsSDK = MealsSDK())): ViewModel() {
    sealed class State() {
        object Initial: State()
        object LocationUpdated: State()
        object Loading: State()
        object Success: State()
        object Failed: State()
    }

    var state: State by mutableStateOf(State.Initial)
        private set

    var meal: MealForm by mutableStateOf(MealForm())
        private set

    private val mealSDKRepository: MealSDKRepository

    init {
        this.mealSDKRepository = mealSDKRepository
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

    fun onEditAvailableFrom(newValue: LocalDate) {
        meal.availableFrom = newValue
    }

    fun onEditUseBy(newValue: LocalDate) {
        meal.useBy = newValue
    }

    fun onEditAddress(newValue: String) {
        meal.address = newValue
    }

    fun onEditLocation(newValue: Location) {
        meal.location = newValue
    }

    fun onSubmit() {
        state = State.Loading
        val availableFrom = meal.availableFrom?.atStartOfDay()?.toEpochSecond(ZoneOffset.UTC).toString()
        val useBy = meal.useBy?.atStartOfDay()?.toEpochSecond(ZoneOffset.UTC).toString()

        viewModelScope.launch {
            kotlin.runCatching {
                val meal = Meal(
                    id = mealSDKRepository.getUUID().toString(),
                    name = meal.title,
                    info = meal.additionalInformation,
                    quantity = meal.quantity.toInt(),
                    availableFromDate = availableFrom,
                    expiryDate = useBy,
                    hot = meal.isHot,
                    locationLat = meal.location.latitude.toFloat(),
                    locationLong = meal.location.longitude.toFloat(),
                    distance = null
                )
                mealSDKRepository.postMeal(meal = meal)
            }.onSuccess {
                meal = MealForm()
                state = State.Success
            }.onFailure {
                state = State.Failed
            }
        }
    }
}