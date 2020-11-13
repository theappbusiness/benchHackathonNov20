package com.kcc.kmmhackathon.shared

actual class Platform actual constructor() {
    actual val platform: String = "Android ${android.os.Build.VERSION.SDK_INT}"

    actual fun isAndroid(): Boolean {
        return true
    }
}