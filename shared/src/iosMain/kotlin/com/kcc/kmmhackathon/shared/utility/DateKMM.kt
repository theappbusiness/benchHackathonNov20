package com.kcc.kmmhackathon.shared.utility

import platform.Foundation.*

actual class DateKMM {

    private var date: NSDate

    actual constructor() {
        date = NSDate()
    }

    actual constructor(time: Long) {
        date = NSDate.dateWithTimeIntervalSince1970(time.toDouble())
    }

    constructor(platformDate: NSDate) {
        date = platformDate
    }

    actual fun compareTo(other: DateKMM): Int {
        return when (this.date.compare(other.date)) {
            NSOrderedAscending -> -1
            NSOrderedDescending -> 1
            else -> 0
        }
    }

    actual fun getTime(): Long = date.timeIntervalSince1970.toLong()

    fun toPlatformDate() = date
}