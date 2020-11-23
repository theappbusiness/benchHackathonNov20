package com.kcc.kmmhackathon.shared.utility

import java.time.Instant
import java.time.LocalDateTime
import java.time.ZoneId
import java.time.format.DateTimeFormatter
import java.util.*

actual typealias SharedDate = Date

fun timeInMillisToReadableString(timeInMillis: Long): String {
    val formatter = DateTimeFormatter.ofPattern("EEE dd MMM YYYY HH:mm")
    val date = LocalDateTime.ofInstant(Instant.ofEpochMilli(timeInMillis), ZoneId.systemDefault())
    return "${date.format(formatter)}"
}