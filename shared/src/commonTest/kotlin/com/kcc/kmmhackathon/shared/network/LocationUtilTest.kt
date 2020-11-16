package com.kcc.kmmhackathon.shared.network

import com.kcc.kmmhackathon.shared.utility.LocationUtil
import kotlin.math.round
import kotlin.test.Test
import kotlin.test.assertEquals

class LocationUtilTest {

    @Test
    fun testGetDistance_LondonToParis() {
        val locationUtil = LocationUtil()

        // London
        val latitude1 = 51.509865
        val longitude1 = -0.118092

        // Paris
        val latitude2 =	48.864716
        val longitude2 = 2.349014

        val distanceInMiles = locationUtil.getDistance(latitude1, longitude1, latitude2, longitude2, inMiles = true)
        val distanceInKM = locationUtil.getDistance(latitude1, longitude1, latitude2, longitude2, inMiles = false)

        assertEquals(212.84, distanceInMiles)
        assertEquals(342.54, distanceInKM)
    }

    @Test
    fun testGetDistance_KandCToTrafalgerSquare() {
        val locationUtil = LocationUtil()

        // Kin and Carta Create
        val latitude1 = 51.5320272
        val longitude1 = -0.1211012

        // London Trafalger Square
        val latitude2 =	51.50809
        val longitude2 = -0.1302322

        val distanceInMiles = locationUtil.getDistance(latitude1, longitude1, latitude2, longitude2, inMiles = true)
        val distanceInKM = locationUtil.getDistance(latitude1, longitude1, latitude2, longitude2, inMiles = false)

        assertEquals(1.7, distanceInMiles)
        assertEquals(2.74, distanceInKM)
    }
}