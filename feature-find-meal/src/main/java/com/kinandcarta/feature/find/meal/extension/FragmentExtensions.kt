package com.kinandcarta.feature.find.meal.extension

import android.Manifest
import android.widget.Toast
import androidx.fragment.app.Fragment

fun Fragment.requestFineLocationPermission(requestCode: Int) { // TODO: Create a module where all these helpful fragment extensions can go and be reused across the project
    requestPermissions(arrayOf(Manifest.permission.ACCESS_FINE_LOCATION), requestCode)
}

fun Fragment.showToast(text: String, duration: Int = Toast.LENGTH_LONG) {
    Toast.makeText(requireContext(), text, duration).show()
}