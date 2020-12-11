package com.kinandcarta.lib.add.meal.ui.components

import androidx.compose.material.Text
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.TextField
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.input.TextFieldValue

@Composable
fun InputTextField(
    title: String,
    placeholder: String,
    value: String,
    onValueChange: (String) -> Unit,
    keyboardType: KeyboardType = KeyboardType.Ascii,
    maxLines: Int = Int.MAX_VALUE,
) {
    val textState = remember { mutableStateOf(TextFieldValue(value)) }
    Column {
        Text(title)
        TextField(
            value = textState.value,
            onValueChange = { newValue ->
                textState.value = newValue
                onValueChange(newValue.text)
            },
            placeholder = {
                Text(text = placeholder)
            },
            keyboardOptions = KeyboardOptions(keyboardType = keyboardType),
            maxLines = maxLines
        )
    }
}