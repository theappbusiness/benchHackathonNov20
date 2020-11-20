package com.kcc.kmmhackathon.shared.network

import com.kcc.kmmhackathon.shared.utility.DistanceUnit
import com.kcc.kmmhackathon.shared.utility.LocationUtil
import kotlin.test.Test
import kotlin.test.assertEquals

class LocationUtilTest {

    @Test
    fun testGetDistance_KandCToTrafalgerSquare() {
        val locationUtil = LocationUtil()

        // Kin and Carta Create
        val latitude1 = 51.5320272
        val longitude1 = -0.1211012

        // London Trafalger Square
        val latitude2 = 51.50809
        val longitude2 = -0.1302322

        val distanceInMiles = locationUtil.getDistance(latitude1, longitude1, latitude2, longitude2, DistanceUnit.miles.ordinal)
        val distanceInKM = locationUtil.getDistance(latitude1, longitude1, latitude2, longitude2, DistanceUnit.km.ordinal)

        assertEquals(1.7, distanceInMiles)
        assertEquals(2.74, distanceInKM)
    }
}