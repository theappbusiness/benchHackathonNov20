package com.kcc.kmmhackathon.shared.utility

import android.os.Build
import androidx.annotation.RequiresApi
import java.text.SimpleDateFormat
import java.time.Instant
import java.time.Instant.ofEpochSecond

actual class DateFormattingUtil actual constructor() {
    actual fun convertTimeStamp(timeStamp: Long): String {
        val date = java.util.Date(timeStamp)
        applyPattern("E d MMM")
        return format(date)
    }

    actual companion object {
        val formatter = SimpleDateFormat()
    }
}