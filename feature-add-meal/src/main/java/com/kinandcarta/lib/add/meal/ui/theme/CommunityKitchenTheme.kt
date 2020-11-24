package com.kinandcarta.lib.add.meal.ui

import androidx.compose.material.MaterialTheme
import androidx.compose.material.lightColors
import androidx.compose.runtime.Composable
import androidx.compose.ui.res.colorResource
import com.kinandcarta.lib_.heming.R


@Composable
fun CommunityKitchenTheme(
    content: @Composable () -> Unit
) {
    MaterialTheme(
        colors = lightColors(
            primary = colorResource(id = R.color.colorPrimary),
            primaryVariant = colorResource(id = R.color.colorPrimaryDark),
        ),
        content = content
    )
}