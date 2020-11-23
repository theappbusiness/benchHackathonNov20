package com.kcc.kmmhackathon.shared.utility

import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertFalse
import kotlin.test.assertTrue

class SharedDateTest {

    val dateNow = SharedDate()
    val pastDate = SharedDate(0)
    val pastDateInSeconds = pastDate.getTime()
    val dateNowInSeconds = dateNow.getTime()

    @Test
    fun testSharedDate_createsDateUnixTimeSuccessfully() {
        val day1: Long = 0
        val millenium: Long = 946684800
        assertEquals(pastDateInSeconds, day1)
        assertEquals(SharedDate(946684800).getTime(), millenium)
        assertTrue(SharedDate().toString().isNotEmpty())
    }

    @Test
    fun testSharedDate_whenDateComparedIsAfter_returnsNegativeNumber() {
        assertTrue(pastDate.compareTo(dateNow) < 0)
        assertTrue(pastDateInSeconds.compareTo(dateNowInSeconds) < 0)
    }

    @Test
    fun testSharedDate_whenComparedDateIsBefore_returnsPostiveNumber() {
        assertTrue(dateNow.compareTo(pastDate) > 0)
        assertTrue(dateNowInSeconds.compareTo(pastDateInSeconds) > 0)
    }

    @Test
    fun testSharedDate_whenComparedDateIsEqual_returnsZero() {
        assertEquals(pastDate.compareTo(pastDate), 0)
        assertEquals(pastDateInSeconds.compareTo(pastDateInSeconds), 0)
    }
}