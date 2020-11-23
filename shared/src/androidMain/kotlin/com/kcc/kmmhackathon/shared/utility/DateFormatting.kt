package com.kcc.kmmhackathon.shared.utility

import android.os.Build
import androidx.annotation.RequiresApi
import java.text.SimpleDateFormat
import java.time.Instant
import java.time.Instant.ofEpochSecond

actual class DateFormatting actual constructor() {
    private val formatter = SimpleDateFormat()
    actual fun convertTimeStamp(timeStamp: Long): String {
        val date = java.util.Date(timeStamp)
        formatter.applyPattern("E d MMM")
        return formatter.format(date)
    }
}