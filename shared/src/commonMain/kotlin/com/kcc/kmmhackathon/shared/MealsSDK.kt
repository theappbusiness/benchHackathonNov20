package com.kcc.kmmhackathon.shared

import com.benasher44.uuid.Uuid
import com.benasher44.uuid.uuid4
import com.kcc.kmmhackathon.shared.entity.Meal
import com.kcc.kmmhackathon.shared.entity.MealWithDistance
import com.kcc.kmmhackathon.shared.network.MealApi

class MealsSDK {
    private val api = MealApi()

    @Throws(Exception::class) suspend fun getMeal(id: String): Meal {
        return api.getMeal(id)
    }

    @Throws(Exception::class) suspend fun getMeals(forceReload: Boolean): List<Meal> {
        return api.getAllMeals()
    }

    @Throws(Exception::class) suspend fun getMeals(userLat: Double, userLon: Double, distanceUnit: Int, forceReload: Boolean): List<MealWithDistance> {
        return api.getAllMeals(userLat, userLon, distanceUnit)
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