package com.kcc.kmmhackathon.shared

expect class Platform() {
    val platform: String

    fun isAndroid(): Boolean
}
