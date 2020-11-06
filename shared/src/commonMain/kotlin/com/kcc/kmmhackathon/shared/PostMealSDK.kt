package com.kcc.kmmhackathon.shared

import com.kcc.kmmhackathon.shared.entity.Meal
import com.kcc.kmmhackathon.shared.network.PostMealApi

class PostMealSDK {
    private val api = PostMealApi()

    @Throws(Exception::class) suspend fun postMeal(): String {
        return api.postMeal()
    }
}