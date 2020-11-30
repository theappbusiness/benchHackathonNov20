package com.kcc.kmmhackathon.shared.utility.extensions

fun Int.getPortionsString() : String = when (this) {
    0 -> "Reserved"
    1 -> "$this portion remaining"
    else -> "$this portions remaining"
}
