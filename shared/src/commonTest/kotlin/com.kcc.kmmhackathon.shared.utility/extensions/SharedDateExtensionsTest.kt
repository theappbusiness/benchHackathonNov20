package com.kcc.kmmhackathon.shared.utility.extensions

import com.kcc.kmmhackathon.shared.utility.SharedDate
import kotlin.test.Test
import kotlin.test.assertFalse
import kotlin.test.assertTrue

class SharedDateExtensionsTest {

    val dateNow = SharedDate()
    val pastDate = SharedDate(0)

    @Test
    fun testSharedDate_isAfter_whenDateIsAfter_returnsTrue() {
        assertTrue(dateNow.isAfter(pastDate))
    }

    @Test
    fun testSharedDate_isAfter_whenDateIsBefore_returnsFalse() {
        assertFalse(pastDate.isAfter(dateNow))
    }

    @Test
    fun testSharedDate_isAfter_whenDateIsEqual_returnsFalse() {
        assertFalse(pastDate.isAfter(pastDate))
    }

    @Test
    fun testSharedDate_isBefore_whenDateIsAfter_returnsFalse() {
        assertFalse(dateNow.isBefore(pastDate))
    }

    @Test
    fun testSharedDate_isBefore_whenDateIsBefore_returnsTrue() {
        assertTrue(pastDate.isBefore(dateNow))
    }

    @Test
    fun testSharedDate_isBefore_whenDateIsEqual_returnsFalse() {
        assertFalse(pastDate.isBefore(pastDate))
    }

    @Test
    fun testSharedDate_isEqual_whenDateIsAfter_returnsFalse() {
        assertFalse(dateNow.isEqual(pastDate))
    }

    @Test
    fun testSharedDate_isEqual_whenDateIsBefore_returnsFalse() {
        assertFalse(pastDate.isEqual(dateNow))
    }

    @Test
    fun testSharedDate_isEqual_whenDateIsEqual_returnsTrue() {
        assertTrue(pastDate.isEqual(pastDate))
    }
}