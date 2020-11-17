package com.kcc.kmmhackathon.shared.utility

import kotlin.math.round

fun Double.round(decimals: Int): Double {
    var multiplier = 1.0
    repeat(decimals) { multiplier *= 10 }
    return round(this * multiplier) / multiplier
}

fun Double.toKilometres(): Double = this * 1.609344