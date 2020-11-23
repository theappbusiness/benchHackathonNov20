package com.kcc.kmmhackathon.shared.utility

import kotlin.test.Test
import kotlin.test.assertEquals

class DateFormattingTest {

    @Test
    fun testDateFormattingTest() {
        assertEquals(DateFormattingUtil().convertTimeStamp(0), "Thu 1 Jan")
    }
}