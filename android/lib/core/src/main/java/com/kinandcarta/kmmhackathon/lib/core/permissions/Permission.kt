package com.kinandcarta.kmmhackathon.lib.core.permissions

import android.Manifest.permission.ACCESS_FINE_LOCATION
import android.Manifest.permission.WRITE_EXTERNAL_STORAGE

sealed class Permission(vararg val permissions: String) {
    object Location : Permission(ACCESS_FINE_LOCATION)

    companion object {
        fun from(permission: String) = when(permission) {
            ACCESS_FINE_LOCATION -> Location
            else -> throw IllegalArgumentException("Unknown permission: $permission")
        }
    }
}
