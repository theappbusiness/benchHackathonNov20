package com.kinandcarta.lib.add.meal.ui.components

import androidx.compose.material.Text
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.material.Button
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import com.kcc.kmmhackathon.shared.utility.DateFormattingUtil
import com.vanpra.composematerialdialogs.MaterialDialog
import com.vanpra.composematerialdialogs.datetime.datepicker
import java.sql.Timestamp
import java.time.LocalDate
import java.time.ZoneOffset

@Composable
fun DateField(title: String, value: String, onValueChange: (LocalDate) -> Unit) {
    var date = remember { mutableStateOf(value) }
    val dialog = MaterialDialog()
    dialog.build {
        datepicker { dateSelected ->
            date.value = DateFormattingUtil().convertTimeStamp(dateSelected.atStartOfDay().toEpochSecond(ZoneOffset.UTC))
            onValueChange(dateSelected)
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