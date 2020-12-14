package com.kinandcarta.feature.find.meal.utility

import android.Manifest
import android.content.pm.PackageManager

class PermissionResultParser {

    fun isFineLocationPermissionsGranted(permissions: Array<out String>, grantResults: IntArray): Boolean =
        isPermissionTypeGranted(Manifest.permission.ACCESS_FINE_LOCATION, permissions, grantResults)

    fun isPermissionTypeGranted(type: String, permissionsToCheckAgainst: Array<out String>, grantResults: IntArray): Boolean {
        permissionsToCheckAgainst.withIndex().forEach {
            when (it.value) {
                type -> return grantResults[it.index] == PackageManager.PERMISSION_GRANTED
            }
        }
        return false
    }
}