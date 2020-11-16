package com.kcc.kmmhackathon.shared.network

import kotlin.test.Test
import kotlin.test.assertTrue

class MealEndpointTestIOS {

    @Test
    fun testMealEndpoint() {
        assertTrue("localhost" in MealEndpoint().endpointString)
    }
}