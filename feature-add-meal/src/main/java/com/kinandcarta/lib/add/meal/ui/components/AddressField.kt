package com.kinandcarta.lib.add.meal.ui.components

import android.content.Context
import androidx.compose.material.Text
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.TextField
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.LocationOn
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import com.kinandcarta.lib.add.meal.util.LocationUtil

@Composable
fun AddressField(context: Context, onValueChange: (String) -> Unit) {
    val location = remember { mutableStateOf("") }
    Column {
        Text("Address")
        Row {
            TextField(value = location.value, onValueChange = { })
            IconButton(onClick = {
                LocationUtil.getCurrentLocation(context, onUpdate = {
                    location.value = it
                    onValueChange(it)
                })
            }) {
                Icon(Icons.Filled.LocationOn)
            }
        }
    }
}