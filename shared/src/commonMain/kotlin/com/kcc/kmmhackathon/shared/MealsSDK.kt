package com.kcc.kmmhackathon.shared

import com.benasher44.uuid.Uuid
import com.benasher44.uuid.uuid4
import com.kcc.kmmhackathon.shared.entity.Meal
import com.kcc.kmmhackathon.shared.network.MealApi
import com.kcc.kmmhackathon.shared.utility.DateFormattingUtil
import com.kcc.kmmhackathon.shared.utility.DistanceUnit
import com.kcc.kmmhackathon.shared.utility.LocationUtil
import com.kcc.kmmhackathon.shared.utility.SharedDate
import com.kcc.kmmhackathon.shared.utility.extensions.isBefore

class MealsSDK {
    private val api = MealApi()
    private val locationUtil = LocationUtil()
    private val dateFormattingUtil = DateFormattingUtil()


    @Throws(Exception::class) suspend fun getMeal(id: String): Meal {
        return api.getMeal(id)
    }

    @Throws(Exception::class) suspend fun getSortedMeals(userLat: Double, userLon: Double, distanceUnit: DistanceUnit): List<Meal> {
        var meals: List<Meal> = api.getAllMeals()
        meals.filter { SharedDate().isBefore(SharedDate(it.expiryDate.toLong())) }
        meals.forEach {
            it.distance = locationUtil.getDistance(
                userLat,
                userLon,
                it.locationLat.toDouble(),
                it.locationLong.toDouble(),
                distanceUnit
            )
            it.expiryDate = dateFormattingUtil.convertTimeStamp(it.expiryDate.toLong())
            it.availableFromDate = dateFormattingUtil.convertTimeStamp(it.availableFromDate.toLong())
        }
        return meals.sortedBy { it.distance }
    }

    @Throws(Exception::class) suspend fun postMeal(meal: Meal): Meal {
        return api.postMeal(meal)
    }

    @Throws(Exception::class) suspend fun patchMeal(id: String, quantity: Int): Meal {
        return api.patchMeal(id, quantity)
    }

    @Throws(Exception::class) suspend fun reserveMeal(id: String): Meal? {
        val meal = getMeal(id)
        if (meal.quantity > 0) {
            return api.patchMeal(meal.id, meal.quantity - 1)
        }
        return null
    }

    fun getUUID(): Uuid {
        return uuid4()
    }
}