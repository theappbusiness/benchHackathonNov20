package com.kinandcarta.feature.find.meal.ui

import android.view.View
import com.google.android.material.bottomsheet.BottomSheetBehavior
import javax.inject.Inject

class BottomSheetBehaviourCallback @Inject constructor() :
    BottomSheetBehavior.BottomSheetCallback() {

    private var onCollapsed: () -> Unit = {}
    private var onExpanded: () -> Unit = {}

    fun setup(
        onCollapsed: () -> Unit = {},
        onExpanded: () -> Unit = {}
    ) {
        this.onCollapsed = onCollapsed
        this.onExpanded = onExpanded
    }

    override fun onStateChanged(bottomSheet: View, newState: Int) {
        when (newState) {
            BottomSheetBehavior.STATE_EXPANDED -> onExpanded()
            BottomSheetBehavior.STATE_COLLAPSED -> onCollapsed()
            else -> {
                // Nothing for now
            }
        }
    }

    override fun onSlide(bottomSheet: View, slideOffset: Float) {
        // Nothing for now
    }
}