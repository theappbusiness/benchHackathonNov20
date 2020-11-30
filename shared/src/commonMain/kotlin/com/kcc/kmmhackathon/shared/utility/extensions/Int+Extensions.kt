package com.kcc.kmmhackathon.shared.utility.extensions

fun Int.getPortionsString(): String = when (this) {
    in 2 .. Int.MAX_VALUE -> "$this portions remaining"
    1 -> "$this portion remaining"
    else -> "Reserved"
}
