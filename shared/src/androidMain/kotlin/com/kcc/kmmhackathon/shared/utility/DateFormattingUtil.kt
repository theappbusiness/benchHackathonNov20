package com.kcc.kmmhackathon.shared.utility

import java.text.SimpleDateFormat

actual class DateFormattingUtil actual constructor() {
    actual fun convertTimeStamp(timeStamp: Long): String {
        val date = java.util.Date(timeStamp)
        return formatter.format(date)
    }

    actual companion object {
        val formatter = SimpleDateFormat("E d MMM")
    }
}