package com.kcc.kmmhackathon.shared
import com.kcc.kmmhackathon.shared.entity.Meal
import com.kcc.kmmhackathon.shared.network.PostMealApi
import io.ktor.client.features.json.JsonFeature
import io.ktor.client.features.json.serializer.KotlinxSerializer
import kotlinx.serialization.json.Json

class PostMealSDK {

    private val api = PostMealApi()

    @Throws(Exception::class) suspend fun postMeal(meal: Meal): Meal {
        return api.postMeal(meal)
    }
}