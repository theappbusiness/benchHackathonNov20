package com.kcc.kmmhackathon.shared.network

import com.kcc.kmmhackathon.shared.entity.Meal
import io.ktor.client.HttpClient
import io.ktor.client.features.*
import io.ktor.client.features.json.JsonFeature
import io.ktor.client.features.json.serializer.KotlinxSerializer
import io.ktor.client.request.*
import kotlinx.serialization.json.Json


class PostMealApi() {
    private val httpClient = HttpClient {
        install(JsonFeature) {
            val json = Json { ignoreUnknownKeys = true }
            serializer = KotlinxSerializer(json)
        }
    }


    suspend fun postMeal(): String {
        return httpClient.post(MEALS_ENDPOINT) {
            url(MEALS_ENDPOINT)
            parameter("name", "test")
            parameter("quantity", "3")
            parameter("availableFrom", "test")
            parameter("info", "test")
            parameter("expiryDate", "test")
            parameter("hot", "false")
        }

    }

    companion object {
        private const val MEALS_ENDPOINT = "http://localhost:3000/Meals"
    }
}