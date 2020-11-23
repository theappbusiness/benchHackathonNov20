package com.kcc.kmmhackathon.shared.utility

import platform.Foundation.*

actual class DateFormattingUtil actual constructor() {

    actual fun convertTimeStamp(timeStamp: Long): String {
        val date = NSDate.dateWithTimeIntervalSince1970(timeStamp.toDouble())
        dateFormat = "E d MMM"
        return stringFromDate(date)
    }

    actual companion object Formatter: NSDateFormatter()
}