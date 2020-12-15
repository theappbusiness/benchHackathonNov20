package com.kinandcarta.lib.add.meal.util

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.location.*
import androidx.core.app.ActivityCompat
import java.util.*

class LocationUtil {

    companion object {

        @JvmStatic
        fun getCurrentLocation(context: Context, onUpdate: (String) -> Unit) {
            val locationListener: LocationListener = object : LocationListener {
                override fun onLocationChanged(location: Location) {
                    val geocoder = Geocoder(context, Locale.getDefault())
                    val addresses: List<Address> =
                        geocoder.getFromLocation(location.latitude, location.longitude, 1)
                    if (addresses.isEmpty()) {

                    } else {
                        onUpdate(addresses[0].getAddressLine(0))
                    }
                }
            }

            val minMS: Long = 0
            val distanceMin: Float = 0.0f
            val locationManager =
                context.getSystemService(Context.LOCATION_SERVICE) as LocationManager
            if (ActivityCompat.checkSelfPermission(
                    context,
                    Manifest.permission.ACCESS_FINE_LOCATION
                ) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(
                    context,
                    Manifest.permission.ACCESS_COARSE_LOCATION
                ) != PackageManager.PERMISSION_GRANTED
            ) {
                return
            }
            locationManager.requestLocationUpdates(
                LocationManager.GPS_PROVIDER,
                minMS,
                distanceMin,
                locationListener
            )
        }
    }
}