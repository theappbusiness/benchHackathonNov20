package com.kcc.kmmhackathon.shared.utility

import com.kcc.kmmhackathon.shared.utility.round
import com.kcc.kmmhackathon.shared.utility.toKilometres
import kotlin.test.Test
import kotlin.test.assertEquals

class ExtensionsTest {

    @Test
    fun testDouble_Round() {
        val testPi = 3.14159
        val testNegPi = -3.14159

        assertEquals(testPi.round(0), 3.0)
        assertEquals(testPi.round(2), 3.14)
        assertEquals(testPi.round(4), 3.1416)
        assertEquals(testPi.round(8), 3.14159000)

        assertEquals(testNegPi.round(0), -3.0)
        assertEquals(testNegPi.round(2), -3.14)
        assertEquals(testNegPi.round(4), -3.1416)
        assertEquals(testNegPi.round(8), -3.14159000)
    }

    @Test
    fun testDouble_ToKilometres() {
        val oneMile = 1.0
        val marathon = 26.2

        assertEquals(oneMile.toKilometres(), 1.609344)
        assertEquals(marathon.toKilometres(), 42.1648128)
    }
}