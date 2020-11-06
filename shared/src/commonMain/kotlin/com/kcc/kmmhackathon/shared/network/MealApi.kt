package com.kcc.kmmhackathon.shared.network

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
        defaultRequest {
            header("secret-key", "\$2b\$10\$zAulGredtvb5w9Z8hZ5IjOFKu6uCKPRmxZN6T1A6Xnebpbf8LlvJa")
        }
    }

    suspend fun getAllMeals(): List<Meal> {
        return httpClient.get(MEALS_ENDPOINT)
    }

    companion object {
        private const val MEALS_ENDPOINT = "https://api.jsonbin.io/b/5fa44c571e633a56cf8da38f/5"
    }
}