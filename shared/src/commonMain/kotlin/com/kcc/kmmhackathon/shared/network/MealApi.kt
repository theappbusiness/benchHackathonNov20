package com.kcc.kmmhackathon.shared.network

import com.kcc.kmmhackathon.shared.entity.Meal
import com.kcc.kmmhackathon.shared.entity.MealWithDistance
import com.kcc.kmmhackathon.shared.entity.Quantity
import com.kcc.kmmhackathon.shared.utility.LocationUtil
import io.ktor.client.HttpClient
import io.ktor.client.features.*
import io.ktor.client.request.*
import io.ktor.client.features.json.JsonFeature
import io.ktor.client.features.json.serializer.KotlinxSerializer
import kotlinx.serialization.json.Json
import io.ktor.http.*

class MealApi {
    val locationUtil = LocationUtil()

    private val httpClient = HttpClient {
        install(JsonFeature) {
            val json = Json { ignoreUnknownKeys = true }
            serializer = KotlinxSerializer(json)
        }
    }

    suspend fun getMeal(id: String): Meal {
        return httpClient.get("$endpoint/$id")
    }

    suspend fun getAllMeals(): List<Meal> {
        return httpClient.get(endpoint)
    }

    suspend fun getAllMeals(userLat: Double, userLon: Double, inMiles: Boolean): List<MealWithDistance> {
        var meals = getAllMeals()
        var mealsWithDistance = mutableListOf<MealWithDistance>()
        return meals.mapTo(mealsWithDistance, { meal ->
            val distance = locationUtil.getDistance(userLat, userLon, meal.locationLat.toDouble(), meal.locationLong.toDouble(), inMiles)
            MealWithDistance(meal, distance)
        })
    }

    suspend fun postMeal(meal: Meal): Meal {
        return httpClient.post(endpoint) {
            contentType(ContentType.Application.Json)
            body = meal
        }
    }

    suspend fun patchMeal(id: String, quantity: Int): Meal {
        return httpClient.patch("$endpoint/${id}") {
            contentType(ContentType.Application.Json)
            body = Quantity(quantity)
        }
    }

    companion object {
        private val endpoint = MealEndpoint().endpointString
    }
}