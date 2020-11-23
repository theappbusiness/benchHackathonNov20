package com.kcc.kmmhackathon.shared.utility

import platform.Foundation.*

actual class DateFormatting actual constructor() {

    private val formatter = NSDateFormatter()

    actual fun convertTimeStamp(timeStamp: Long): String {
        val date = NSDate.dateWithTimeIntervalSince1970(timeStamp.toDouble())
        formatter.dateFormat = "E d MMM"
        return formatter.stringFromDate(date)
    }
}