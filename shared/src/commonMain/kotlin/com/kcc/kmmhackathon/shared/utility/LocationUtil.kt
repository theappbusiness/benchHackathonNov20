package com.kcc.kmmhackathon.shared.utility

import kotlin.math.*

typealias Radian = Double
typealias Degree = Double

class LocationUtil {

    fun getDistance(lat1: Double, lon1: Double, lat2: Double, lon2: Double, distanceUnit: Int): Double {

        // Haversine formula  https://www.movable-type.co.uk/scripts/latlong.html
        val earthRadius = 3958.75
        val dLat = (lat1 - lat2).toRadian()
        val dLon = (lon1 - lon2).toRadian()

        val a: Double = sin(dLat / 2) * sin(dLat / 2) +
                cos(lat2.toRadian()) * cos(lat1.toRadian()) *
                sin(dLon / 2) * sin(dLon / 2)
        val c: Double = 2 * atan2(sqrt(a), sqrt(1 - a))
        val distance: Double = earthRadius * c

        return when (distanceUnit) {
            0 -> distance.toKilometres().round(2)  // kilometres
            else -> distance.round(2)  // miles
        }
    }

    // Helper functions
    private fun Degree.toRadian(): Radian = this / 180 * PI
}

