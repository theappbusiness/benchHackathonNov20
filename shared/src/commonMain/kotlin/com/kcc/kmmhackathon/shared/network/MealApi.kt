package com.kcc.kmmhackathon.shared.network

import com.benasher44.uuid.Uuid
import com.benasher44.uuid.uuid4
import com.kcc.kmmhackathon.shared.entity.Meal
import io.ktor.client.HttpClient
import io.ktor.client.features.*
import io.ktor.client.features.json.JsonFeature
import io.ktor.client.features.json.serializer.KotlinxSerializer
import io.ktor.client.request.*
import kotlinx.serialization.json.Json

class MealApi {
    private val httpClient = HttpClient {
        install(JsonFeature) {
            val json = Json { ignoreUnknownKeys = true }
            serializer = KotlinxSerializer(json)
        }
    }

    suspend fun getAllMeals(): List<Meal> {
        return httpClient.get(MEALS_ENDPOINT)
    }

    fun getUUID(): Uuid {
        return uuid4()
    }

    companion object {
        // iOS can use this endpoint
        private const val MEALS_ENDPOINT = "http://localhost:3000/Meals"

        // Android needs to switch to this endpoint
        // private const val MEALS_ENDPOINT = "http://10.0.2.2:3000/meals"
    }
}