package com.kcc.kmmhackathon.shared.utility

expect class DateFormattingUtil() {
    fun convertTimeStamp(timeStamp: Long): String

    companion object
}