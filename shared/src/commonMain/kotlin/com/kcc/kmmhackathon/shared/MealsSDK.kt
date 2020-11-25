package com.kcc.kmmhackathon.shared

import com.benasher44.uuid.Uuid
import com.benasher44.uuid.uuid4
import com.kcc.kmmhackathon.shared.entity.Meal
import com.kcc.kmmhackathon.shared.network.MealApi
import com.kcc.kmmhackathon.shared.utility.DistanceUnit

class MealsSDK {
    private val api = MealApi()

    @Throws(Exception::class) suspend fun getMeal(id: String): Meal {
        return api.getMeal(id)
    }

    @Throws(Exception::class) suspend fun getSortedMeals(userLat: Double, userLon: Double, distanceUnit: DistanceUnit): List<Meal> {
        return api.getSortedMeals(userLat, userLon, distanceUnit)
    }

    @Throws(Exception::class) suspend fun reserveAMeal(id: String): Meal {
        return api.reserveAMeal(id)
    }

    @Throws(Exception::class) suspend fun postMeal(meal: Meal): Meal {
        return api.postMeal(meal)
    }

    @Throws(Exception::class) suspend fun patchMeal(id: String, quantity: Int): Meal {
        return api.patchMeal(id, quantity)
    }

    fun getUUID(): Uuid {
        return uuid4()
    }
}