package com.kinandcarta.lib.add.meal.network

import com.benasher44.uuid.Uuid
import com.kcc.kmmhackathon.shared.entity.Meal
import com.kcc.kmmhackathon.shared.utility.DistanceUnit

interface MealSDKRepository {
    @Throws(Exception::class)
    suspend fun getMeal(id: String): Meal

    @Throws(Exception::class)
    suspend fun getSortedMeals(
        userLat: Double,
        userLon: Double,
        distanceUnit: DistanceUnit
    ): List<Meal>

    @Throws(Exception::class)
    suspend fun postMeal(meal: Meal): Meal

    @Throws(Exception::class)
    suspend fun patchMeal(
        id: String,
        quantity: Int
    ): Meal

    @Throws(Exception::class)
    suspend fun reserveMeal(id: String): Meal?

    fun getUUID(): Uuid

}