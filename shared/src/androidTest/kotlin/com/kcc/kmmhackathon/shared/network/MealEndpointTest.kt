package com.kcc.kmmhackathon.shared.network

import kotlin.test.Test
import kotlin.test.assertTrue

class MealEndpointTestAND {

    @Test
    fun testMealEndpoint() {
        assertTrue("10.0.2.2" in MealEndpoint().endpointString)
    }
}