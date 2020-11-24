package com.kcc.kmmhackathon.shared.utility

import java.text.SimpleDateFormat

actual class DateFormattingUtil actual constructor() {
    actual fun convertTimeStamp(timeStamp: Long): String {
        val timeStampInMilli = timeStamp*1000
        val date = java.util.Date(timeStampInMilli)
        return formatter.format(date)
    }

    actual companion object {
        val formatter = SimpleDateFormat("E d MMM")
    }
}