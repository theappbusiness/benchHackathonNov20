package com.kcc.kmmhackathon.shared.utility.extensions

import com.kcc.kmmhackathon.shared.utility.SharedDate

fun SharedDate.isAfter(other: SharedDate): Boolean {
    return this.compareTo(other) > 0
}

fun SharedDate.isBefore(other: SharedDate): Boolean {
    return this.compareTo(other) < 0
}

fun SharedDate.isEqual(other: SharedDate): Boolean {
    return this.compareTo(other) == 0
}