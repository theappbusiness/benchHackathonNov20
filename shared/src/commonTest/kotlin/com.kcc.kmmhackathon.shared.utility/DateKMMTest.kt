package com.kcc.kmmhackathon.shared.utility

import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertTrue

class DateKMMTest {

    val dateNow = SharedDate()
    val pastDate = SharedDate(0)
    val pastDateInSeconds = pastDate.getTime()
    val dateNowInSeconds = dateNow.getTime()

    @Test
    fun testDateKMM_createsDateUnixTimeSuccessfully() {
        val day1: Long = 0
        val millenium: Long = 946684800
        assertEquals(pastDateInSeconds, day1)
        assertEquals(SharedDate(946684800).getTime(), millenium)
        assertTrue(SharedDate().toString().isNotEmpty())
    }

    @Test
    fun testDateKMM_dateComparedIsAfter_returnsNegativeNumber() {
        assertTrue(pastDate.compareTo(dateNow) < 0)
        assertTrue(pastDateInSeconds.compareTo(dateNowInSeconds) < 0)
    }

    @Test
    fun testDateKMM_comparedDateIsBefore_returnsPostiveNumber() {
        assertTrue(dateNow.compareTo(pastDate) > 0)
        assertTrue(dateNowInSeconds.compareTo(pastDateInSeconds) > 0)
    }

    @Test
    fun testDateKMM_comparedDateIsEqual_returnsZero() {
        assertEquals(pastDate.compareTo(pastDate), 0)
        assertEquals(pastDateInSeconds.compareTo(pastDateInSeconds), 0)
    }
}