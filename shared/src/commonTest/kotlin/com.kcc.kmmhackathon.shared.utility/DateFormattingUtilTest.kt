package com.kcc.kmmhackathon.shared.utility

import kotlin.test.Test
import kotlin.test.assertEquals

class DateFormattingUtilTest {

    @Test
    fun testDateFormattingUtil_returnsCorrectString() {
        assertEquals(DateFormattingUtil().convertTimeStamp(0), "Thu 1 Jan")
        assertEquals(DateFormattingUtil().convertTimeStamp(946684800), "Sat 1 Jan") 
    }
}