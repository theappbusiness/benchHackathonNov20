package com.kinandcarta.feature.find.meal.extension

fun Int.getPortionsString(): String = when (this) {
    0 -> "Reserved"
    1 -> "$this portion remaining"
    else -> "$this portions remaining"
}
