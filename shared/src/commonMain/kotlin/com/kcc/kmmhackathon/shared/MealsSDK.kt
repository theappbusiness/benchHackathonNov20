package com.kcc.kmmhackathon.shared

import com.kcc.kmmhackathon.shared.entity.Meal
import com.kcc.kmmhackathon.shared.network.MealApi

class MealsSDK {
    private val api = MealApi()

    @Throws(Exception::class) suspend fun getMeals(forceReload: Boolean): List<Meal> {
        return api.getAllMeals()
    }
}