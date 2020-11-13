package com.kcc.kmmhackathon.shared.network

import com.kcc.kmmhackathon.shared.entity.Meal
import com.kcc.kmmhackathon.shared.entity.Quantity
import io.ktor.client.HttpClient
import io.ktor.client.features.*
import io.ktor.client.request.*
import io.ktor.client.features.json.JsonFeature
import io.ktor.client.features.json.serializer.KotlinxSerializer
import kotlinx.serialization.json.Json
import com.kcc.kmmhackathon.shared.Platform
import io.ktor.http.*

class MealApi {

    private val localHostiOS = "http://localhost:"
    private val localHostAnd = "http://10.0.2.2:"

    private val httpClient = HttpClient {
        install(JsonFeature) {
            val json = Json { ignoreUnknownKeys = true }
            serializer = KotlinxSerializer(json)
        }
    }

    suspend fun getMeal(id: String): Meal {
        return httpClient.get("${getEndPoint()}/$id")
    }

    suspend fun getAllMeals(): List<Meal> {
        return httpClient.get(getEndPoint())
    }

    suspend fun postMeal(meal: Meal): Meal {
        return httpClient.post(getEndPoint()) {
            contentType(ContentType.Application.Json)
            body = meal
        }
    }

    suspend fun patchMeal(id: String, quantity: Int): Meal {
        return httpClient.patch("${getEndPoint()}/${id}") {
            contentType(ContentType.Application.Json)
            body = Quantity(quantity)
        }
    }

    private fun getEndPoint(): String {
        if (Platform().isAndroid()) {
            return localHostAnd + MEALS_ENDPOINT
        }
        return localHostiOS + MEALS_ENDPOINT
    }

    companion object {
        private const val MEALS_ENDPOINT = "3000/Meals"
    }
}