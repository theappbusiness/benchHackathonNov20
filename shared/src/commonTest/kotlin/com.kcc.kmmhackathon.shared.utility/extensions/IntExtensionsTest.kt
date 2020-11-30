package com.kcc.kmmhackathon.shared.utility.extensions

import kotlin.test.Test
import kotlin.test.assertEquals

class IntExtensionsTest {

    @Test
    fun testInt_getPortionsString_expectedValues() {
        val loadsAvailable = 200
        val oneAvailable = 1
        val noneAvailable = 0

        assertEquals(loadsAvailable.getPortionsString(), "200 portions remaining")
        assertEquals(oneAvailable.getPortionsString(), "1 portion remaining")
        assertEquals(noneAvailable.getPortionsString(), "Reserved")
    }

    fun testInt_getPortionsString_negativeValues() {
        val negativeOneAvailable = -1
        val negativeLoadsAvailable = -200

        assertEquals(negativeOneAvailable.getPortionsString(), "Reserved")
        assertEquals(negativeLoadsAvailable.getPortionsString(), "Reserved")
    }
}