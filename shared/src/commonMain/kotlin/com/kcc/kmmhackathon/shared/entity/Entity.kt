package com.kcc.kmmhackathon.shared.entity

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class Meal(
    @SerialName("quantity")
    val quantity: Int,
    @SerialName("availableFrom")
    val availableFrom: String,
    @SerialName("info")
    val info: String,
    @SerialName("expiryDate")
    val expiryDate: String,
    @SerialName("hot")
    val hot: Boolean,
    @SerialName("name")
    val name: String
)