package com.kcc.kmmhackathon.shared

import com.benasher44.uuid.Uuid
import com.benasher44.uuid.uuid4
import com.kcc.kmmhackathon.shared.entity.Meal
import com.kcc.kmmhackathon.shared.network.MealApi

class MealsSDK {
    private val api = MealApi()

    @Throws(Exception::class) suspend fun getMeals(forceReload: Boolean): List<Meal> {
        return api.getAllMeals()
    }

    @Throws(Exception::class) suspend fun postMeal(meal: Meal): Meal {
        return api.postMeal(meal)
    }

    fun getUUID(): String {
        return api.getUUID().toString()
    }
}