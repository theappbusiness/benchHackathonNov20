package com.kcc.kmmhackathon.shared.entity

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class Meal(
    @SerialName("id")
    val id: String,
    @SerialName("name")
    val name: String,
    @SerialName("quantity")
    val quantity: Int,
    @SerialName("availableFromDate")
    val availableFromDate: String,
    @SerialName("expiryDate")
    val expiryDate: String,
    @SerialName("info")
    val info: String,
    @SerialName("hot")
    val hot: Boolean,
    @SerialName("locationLat")
    val locationLat: Float,
    @SerialName("locationLong")
    val locationLong: Float,
    @SerialName("distance")
    var distance: Double? = null
)

@Serializable
data class Quantity(
    @SerialName("quantity")
    val quantity: Int
)

data class MealWithDistance(
    @SerialName("meal")
    val meal: Meal,
    @SerialName("distance")
    val distance: Double
)

@Serializable
data class FirebaseAuthenticationResponse(
    val kind: String,
    val idToken: String,
    val email: String,
    val refreshToken: String,
    val expiresIn: String,
    val localId: String,
    val code: Int? = null,
    val message: String? = null
)