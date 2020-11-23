package com.kcc.kmmhackathon.shared.utility

import org.junit.Test
import kotlin.test.assertEquals

class SharedDateAndroidTest {

    @Test
    fun testSharedDate_timeInMillisToReadableString_isAsExpected() {
        val christmasDinner2020: Long = 1608906600000
        assertEquals("Fri 25 Dec 2020 14:30", timeInMillisToReadableString(christmasDinner2020))
    }
}