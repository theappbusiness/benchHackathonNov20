package com.kinandcarta.lib.add.meal.network

import com.benasher44.uuid.Uuid
import com.kcc.kmmhackathon.shared.MealsSDK
import com.kcc.kmmhackathon.shared.entity.Meal
import com.kcc.kmmhackathon.shared.utility.DistanceUnit
import javax.inject.Inject

class MealsSDKRepositoryImpl @Inject constructor(
    private val mealsSDK: MealsSDK,
) : MealSDKRepository {

    override suspend fun getMeal(id: String): Meal {
        return mealsSDK.getMeal(id)
    }

    override suspend fun getSortedMeals(
        userLat: Double,
        userLon: Double,
        distanceUnit: DistanceUnit
    ): List<Meal> {
        return mealsSDK.getSortedMeals(userLat, userLon, distanceUnit)
    }

    override suspend fun postMeal(meal: Meal): Meal {
        return mealsSDK.postMeal(meal)
    }

    override suspend fun patchMeal(id: String, quantity: Int): Meal {
        return mealsSDK.patchMeal(id, quantity)
    }

    override suspend fun reserveMeal(id: String): Meal? {
        return mealsSDK.reserveMeal(id)
    }

    override fun getUUID(): Uuid {
        return mealsSDK.getUUID()
    }
}