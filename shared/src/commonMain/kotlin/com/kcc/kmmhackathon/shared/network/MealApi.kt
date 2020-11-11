package com.kcc.kmmhackathon.shared.network

import com.kcc.kmmhackathon.shared.entity.Meal
import com.kcc.kmmhackathon.shared.entity.Quantity
import io.ktor.client.HttpClient
import io.ktor.client.features.*
import io.ktor.client.request.*
import io.ktor.client.features.json.JsonFeature
import io.ktor.client.features.json.serializer.KotlinxSerializer
import kotlinx.serialization.json.Json
import io.ktor.http.*

class MealApi {
    private val httpClient = HttpClient {
        install(JsonFeature) {
            val json = Json { ignoreUnknownKeys = true }
            serializer = KotlinxSerializer(json)
            defaultRequest {
                url(MEALS_ENDPOINT)
            }
        }
    }

    suspend fun getMeal(id: String): Meal {
        return httpClient.get("$MEALS_ENDPOINT/$id")
    }

    suspend fun getAllMeals(): List<Meal> {
        return httpClient.get(MEALS_ENDPOINT)
    }

    suspend fun postMeal(meal: Meal): Meal {
        return httpClient.post(MEALS_ENDPOINT) {
            contentType(ContentType.Application.Json)
            body = meal
        }
    }

    suspend fun patchMeal(id: String, quantity: Int): Meal {
        return httpClient.patch("$MEALS_ENDPOINT/${id}") {
            contentType(ContentType.Application.Json)
            body = Quantity(quantity)
        }
    }

    companion object {
        private const val MEALS_ENDPOINT = "http://localhost:3000/Meals"
    }
}