package com.kinandcarta.lib.add.meal.ui.components

import androidx.compose.material.Text
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.material.Button
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import com.vanpra.composematerialdialogs.MaterialDialog
import com.vanpra.composematerialdialogs.datetime.datetimepicker
import java.time.LocalDateTime

@Composable
fun DateField(title: String, onValueChange: (LocalDateTime) -> Unit) {
    var date = remember { mutableStateOf(title) }
    val dialog = MaterialDialog()
    dialog.build {
        datetimepicker(title = date.value) { datetime ->
            date.value = datetime.toString()
            onValueChange(datetime)
        }
    }
    Row {
        Text(title)
        Spacer(modifier = Modifier.weight(1f))
        Button(
            onClick = {
                dialog.show()
            }
        ) {
            Text(date.value)
        }
    }
}