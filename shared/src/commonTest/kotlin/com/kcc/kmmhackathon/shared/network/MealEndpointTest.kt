package com.kcc.kmmhackathon.shared.network

import kotlin.test.Test
import kotlin.test.assertTrue

class MealEndpointTest {

    @Test
    fun testMealEndpoint() {
        assertTrue(MealEndpoint().endpointString.isNotEmpty())
    }
}