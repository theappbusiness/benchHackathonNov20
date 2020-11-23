package com.kcc.kmmhackathon.shared.network

import com.kcc.kmmhackathon.shared.entity.Meal
import com.kcc.kmmhackathon.shared.entity.Quantity
import com.kcc.kmmhackathon.shared.utility.*
import com.kcc.kmmhackathon.shared.utility.extensions.isBefore
import io.ktor.client.HttpClient
import io.ktor.client.request.*
import io.ktor.client.features.json.JsonFeature
import io.ktor.client.features.json.serializer.KotlinxSerializer
import kotlinx.serialization.json.Json
import io.ktor.http.*

class MealApi {

    private val locationUtil = LocationUtil()
    private val dateFormattingUtil = DateFormattingUtil()

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

    suspend fun getSortedMeals(userLat: Double, userLon: Double, distanceUnit: DistanceUnit): List<Meal> {
        var meals: List<Meal> = getAllMeals()
            .filter { SharedDate().isBefore(SharedDate(it.expiryDate.toLong())) }

        meals.forEach {
            it.distance = locationUtil.getDistance(
                userLat,
                userLon,
                it.locationLat.toDouble(),
                it.locationLong.toDouble(),
                distanceUnit
            )
            it.expiryDate = dateFormattingUtil.convertTimeStamp(it.expiryDate.toLong())
            it.availableFromDate = dateFormattingUtil.convertTimeStamp(it.availableFromDate.toLong())
        }
        return meals.sortedWith(compareBy { it.distance })
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