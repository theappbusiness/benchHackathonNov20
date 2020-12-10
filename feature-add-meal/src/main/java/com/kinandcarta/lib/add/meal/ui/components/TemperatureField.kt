package com.kinandcarta.lib.add.meal.ui.components

import androidx.compose.material.Text
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.AcUnit
import androidx.compose.material.icons.filled.LocalFireDepartment
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.res.vectorResource

@Composable
fun TemperatureField(
    isHot: Boolean,
    onValueChange: (Boolean) -> Unit
) {
    val hotTintColor = remember { mutableStateOf(if (isHot) Color.Red else Color.Black) }
    val coldTintColor = remember { mutableStateOf(if (!isHot) Color.Blue else Color.Black) }
    Column {
        Text("Temperature")
        Row {
            IconButton(onClick = {
                onValueChange(true)
                hotTintColor.value = Color.Red
                coldTintColor.value = Color.Black
            }) {
                Icon(
                    imageVector = Icons.Filled.LocalFireDepartment,
                    tint = hotTintColor.value
                )
            }
            IconButton(onClick = {
                onValueChange(false)
                hotTintColor.value = Color.Black
                coldTintColor.value = Color.Blue
            }) {
                Icon(
                    imageVector = Icons.Filled.AcUnit,
                    tint = coldTintColor.value
                )
            }
        }
    }
}