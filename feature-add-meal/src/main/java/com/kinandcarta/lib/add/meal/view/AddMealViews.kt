package com.kinandcarta.lib.add.meal.view

import android.annotation.SuppressLint
import android.content.Context
import android.location.*
import androidx.compose.material.Text
import androidx.compose.foundation.layout.*
import androidx.compose.material.AlertDialog
import androidx.compose.material.Button
import androidx.compose.material.CircularProgressIndicator
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import com.kinandcarta.lib.add.meal.ui.components.AddressField
import com.kinandcarta.lib.add.meal.ui.components.DateField
import com.kinandcarta.lib.add.meal.ui.components.InputTextField
import com.kinandcarta.lib.add.meal.ui.components.TemperatureField
import com.kinandcarta.lib.add.meal.viewmodel.AddMealViewModel
import java.util.*

@Composable
internal fun AddMealScreen(addMealViewModel: AddMealViewModel, context: Context) {
    val previousState = remember { mutableStateOf(addMealViewModel.state) }
    val showDialog = remember { mutableStateOf(true) }

    when (addMealViewModel.state) {
        is AddMealViewModel.State.Initial -> {
            LoadedView(addMealViewModel = addMealViewModel, context = context)
        }
        is AddMealViewModel.State.Loading -> {
            LoadingView()
        }
        is AddMealViewModel.State.LocationUpdated -> {
            LoadedView(addMealViewModel = addMealViewModel, context = context)
        }
        is AddMealViewModel.State.Success -> {
            if (previousState.value != AddMealViewModel.State.Success) {
                showDialog.value = true
            }
            LoadedView(addMealViewModel = addMealViewModel, context = context)
            if (showDialog.value) {
                AlertDialog(
                    onDismissRequest = { },
                    title = { Text("Network response") },
                    text = { Text("Successfully submitted") },
                    confirmButton = { },
                    dismissButton = {
                        Button(onClick = { showDialog.value = false } ) {
                            Text("OK")
                        }
                    }
                )
            }
        }
        is AddMealViewModel.State.Failed -> {
            if (previousState.value != AddMealViewModel.State.Failed) {
                showDialog.value = true
            }
            LoadedView(addMealViewModel = addMealViewModel, context = context)
            if (showDialog.value) {
                AlertDialog(
                    onDismissRequest = { },
                    title = { Text("Network response") },
                    text = { Text("Unsuccessfully submitted, please try again later.") },
                    confirmButton = { },
                    dismissButton = {
                        Button(onClick = { showDialog.value = false } ) {
                            Text("OK")
                        }
                    }
                )
            }
        }
    }
    previousState.value = addMealViewModel.state
}

@Composable
internal fun LoadedView(addMealViewModel: AddMealViewModel, context: Context) {
    Column(
        modifier = Modifier.padding(16.dp),
    ) {
        InputTextField(
            title = "Title",
            placeholder = "Enter a title",
            value = addMealViewModel.meal.title,
            onValueChange = addMealViewModel::onEditTitle
        )
        Spacer(modifier = Modifier.height(8.dp))
        InputTextField(
            title = "Additional Information",
            placeholder = "Enter Additional information",
            value = addMealViewModel.meal.additionalInformation,
            onValueChange = addMealViewModel::onEditAdditionalInformation
        )
        Spacer(modifier = Modifier.height(8.dp))
        InputTextField(
            title = "Quantity",
            placeholder = "Enter a quantity",
            value = addMealViewModel.meal.quantity,
            onValueChange = addMealViewModel::onEditQuantity,
            keyboardType = KeyboardType.Number,
            maxLines = 1
        )
        Spacer(modifier = Modifier.height(8.dp))
        TemperatureField(
            isHot = addMealViewModel.meal.isHot,
            onValueChange = addMealViewModel::onEditTemperature
        )
        Spacer(modifier = Modifier.height(8.dp))
        DateField(title = "Available From", value = if (addMealViewModel.meal.availableFrom == null) "Available From" else addMealViewModel.meal.availableFrom.toString(), addMealViewModel::onEditAvailableFrom)
        Spacer(modifier = Modifier.height(8.dp))
        DateField(title = "Use by", value = if (addMealViewModel.meal.useBy == null) "Use by" else addMealViewModel.meal.useBy.toString(), addMealViewModel::onEditUseBy)
        Spacer(modifier = Modifier.height(8.dp))
        AddressField(value = addMealViewModel.meal.address, onRequestCurrentLocation = {
            onRequestLocationAndAddress(context) { location, address ->
                addMealViewModel.onEditLocation(location)
                addMealViewModel.onEditAddress(address.getAddressLine(0))
            }
        })
        Spacer(modifier = Modifier.height(16.dp))
        Button(onClick = addMealViewModel::onSubmit) {
            Text(text = "Add a meal")
        }
    }
}

@Composable
internal fun LoadingView() {
    Column(
        modifier = Modifier.fillMaxSize(),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        CircularProgressIndicator(
            modifier = Modifier.wrapContentWidth(Alignment.CenterHorizontally),
            color = Color.Black
        )
    }
}

@SuppressLint("MissingPermission")
private fun onRequestLocationAndAddress(context: Context, onUpdatedLocation: (Location, Address) -> Unit) {
    val locationListener: LocationListener = object : LocationListener {
        override fun onLocationChanged(location: Location) {
            val geocoder = Geocoder(context, Locale.getDefault())
            val addresses: List<Address> =
                geocoder.getFromLocation(location.latitude, location.longitude, 1)
            if (addresses.isEmpty()) {
                // Do nothing
            } else {
                onUpdatedLocation(location, addresses[0])
            }
        }
    }

    val minMS: Long = 30000 // 30s
    val distanceMin: Float = 100.0f // 100m
    val locationManager =
        context.getSystemService(Context.LOCATION_SERVICE) as LocationManager
    locationManager.requestLocationUpdates(
        LocationManager.GPS_PROVIDER,
        minMS,
        distanceMin,
        locationListener
    )
}