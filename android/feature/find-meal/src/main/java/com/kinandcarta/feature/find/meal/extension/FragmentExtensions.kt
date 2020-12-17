package com.kinandcarta.feature.find.meal.extension

import android.widget.Toast
import androidx.fragment.app.Fragment

fun Fragment.showToast(text: String, duration: Int = Toast.LENGTH_LONG) {
    Toast.makeText(requireContext(), text, duration).show()
}