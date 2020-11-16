package com.kcc.kmmhackathon.androidHackathonApp

import android.Manifest
import android.content.*
import android.content.pm.PackageManager
import android.location.Location
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.os.IBinder
import android.provider.Settings
import android.util.Log
import android.widget.FrameLayout
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.core.view.isVisible
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import com.google.android.material.snackbar.Snackbar
import com.kcc.kmmhackathon.androidHackathonApp.Util.toText
import com.kcc.kmmhackathon.shared.MealsSDK
import com.kcc.kmmhackathon.shared.entity.Meal
import kotlinx.coroutines.MainScope
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch


private const val TAG = "FindMealActivity"
private const val REQUEST_FOREGROUND_ONLY_PERMISSIONS_REQUEST_CODE = 34

class FindMealActivity : AppCompatActivity() {
    private val mainScope = MainScope()

    private lateinit var mealsRecyclerView: RecyclerView
    private lateinit var progressBarView: FrameLayout
    private lateinit var swipeRefreshLayout: SwipeRefreshLayout

    private val sdk = MealsSDK()
    private val mealsAdapter = MealsAdapter(listOf())

    private var foregroundOnlyLocationServiceBound = false

    // Provides location updates for while-in-use feature.
    private var foregroundOnlyLocationService: MyNavigationService? = null

    // Listens for location broadcasts from ForegroundOnlyLocationService.
    private lateinit var foregroundOnlyBroadcastReceiver: ForegroundOnlyBroadcastReceiver

    // Monitors connection to the while-in-use service.
    private val foregroundOnlyServiceConnection = object : ServiceConnection {

        override fun onServiceConnected(name: ComponentName, service: IBinder) {
            val binder = service as MyNavigationService.LocalBinder
            foregroundOnlyLocationService = binder.service
            foregroundOnlyLocationServiceBound = true
        }

        override fun onServiceDisconnected(name: ComponentName) {
            foregroundOnlyLocationService = null
            foregroundOnlyLocationServiceBound = false
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // List
        title = "Find a meal"
        setContentView(R.layout.find_meal_activity)

        mealsRecyclerView = findViewById(R.id.rvMeals)
        progressBarView = findViewById(R.id.progressBar)
        swipeRefreshLayout = findViewById(R.id.swipeContainer)

        mealsRecyclerView.adapter = mealsAdapter
        mealsRecyclerView.layoutManager = LinearLayoutManager(this)

        swipeRefreshLayout.setOnRefreshListener {
            swipeRefreshLayout.isRefreshing = false
            displayMeals(true)
        }
        displayMeals(false)


        foregroundOnlyBroadcastReceiver = ForegroundOnlyBroadcastReceiver()
    }

    override fun onStart() {
        super.onStart()

        val serviceIntent = Intent(this, MyNavigationService::class.java)
        bindService(serviceIntent, foregroundOnlyServiceConnection, Context.BIND_AUTO_CREATE)
    }

    override fun onResume() {
        super.onResume()
        LocalBroadcastManager.getInstance(this).registerReceiver(
            foregroundOnlyBroadcastReceiver,
            IntentFilter(
                MyNavigationService.ACTION_FOREGROUND_ONLY_LOCATION_BROADCAST)
        )
        // TODO: Step 1.0, Review Permissions: Checks and requests if needed.
        if (foregroundPermissionApproved()) {
            foregroundOnlyLocationService?.subscribeToLocationUpdates()
                    ?: Log.d(TAG, "Service Not Bound")
        } else {
            requestForegroundPermissions()
        }

    }

    override fun onPause() {
        LocalBroadcastManager.getInstance(this).unregisterReceiver(
            foregroundOnlyBroadcastReceiver
        )
        super.onPause()
    }

    override fun onStop() {
        if (foregroundOnlyLocationServiceBound) {
            unbindService(foregroundOnlyServiceConnection)
            foregroundOnlyLocationServiceBound = false
        }

        super.onStop()
    }

    override fun onDestroy() {
        super.onDestroy()
        mainScope.cancel()
    }


    private fun displayMeals(needReload: Boolean) {
        progressBarView.isVisible = true
        mainScope.launch {
            kotlin.runCatching {
                sdk.getMeals(needReload)
            }.onSuccess {
                mealsAdapter.mealsList = it
                mealsAdapter.notifyDataSetChanged()
            }.onFailure {
                Toast.makeText(this@FindMealActivity, it.localizedMessage, Toast.LENGTH_SHORT)
                    .show()
            }
            progressBarView.isVisible = false
        }
    }

    // TODO: Step 1.0, Review Permissions: Method checks if permissions approved.
    private fun foregroundPermissionApproved(): Boolean {
        return PackageManager.PERMISSION_GRANTED == ActivityCompat.checkSelfPermission(
            this,
            Manifest.permission.ACCESS_FINE_LOCATION
        )
    }

    // TODO: Step 1.0, Review Permissions: Method requests permissions.
    private fun requestForegroundPermissions() {
        val provideRationale = foregroundPermissionApproved()

        // If the user denied a previous request, but didn't check "Don't ask again", provide
        // additional rationale.
        if (provideRationale) {
            Snackbar.make(
                findViewById(R.id.find_meal_activity),
                R.string.permission_rationale,
                Snackbar.LENGTH_LONG
            )
                .setAction(R.string.ok) {
                    // Request permission
                    ActivityCompat.requestPermissions(
                        this@FindMealActivity,
                        arrayOf(Manifest.permission.ACCESS_FINE_LOCATION),
                        REQUEST_FOREGROUND_ONLY_PERMISSIONS_REQUEST_CODE
                    )
                }
                .show()
        } else {
            Log.d(TAG, "Request foreground only permission")
            ActivityCompat.requestPermissions(
                this@FindMealActivity,
                arrayOf(Manifest.permission.ACCESS_FINE_LOCATION),
                REQUEST_FOREGROUND_ONLY_PERMISSIONS_REQUEST_CODE
            )
        }
    }

    // TODO: Step 1.0, Review Permissions: Handles permission result.
    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<String>,
        grantResults: IntArray
    ) {
        Log.d(TAG, "onRequestPermissionResult")

        when (requestCode) {
            REQUEST_FOREGROUND_ONLY_PERMISSIONS_REQUEST_CODE -> when {
                grantResults.isEmpty() ->
                    // If user interaction was interrupted, the permission request
                    // is cancelled and you receive empty arrays.
                    Log.d(TAG, "User interaction was cancelled.")

                grantResults[0] == PackageManager.PERMISSION_GRANTED ->
                    // Permission was granted.
                    foregroundOnlyLocationService?.subscribeToLocationUpdates()

                else -> {
                    // Permission denied.
//                    updateButtonState(false)

                    Snackbar.make(
                        findViewById(R.id.find_meal_activity),
                        R.string.permission_denied_explanation,
                        Snackbar.LENGTH_LONG
                    )
                        .setAction(R.string.settings) {
                            // Build intent that displays the App settings screen.
                            val intent = Intent()
                            intent.action = Settings.ACTION_APPLICATION_DETAILS_SETTINGS
                            val uri = Uri.fromParts(
                                "package",
                                BuildConfig.APPLICATION_ID,
                                null
                            )
                            intent.data = uri
                            intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                            startActivity(intent)
                        }
                        .show()
                }
            }
        }
    }


    /**
     * Receiver for location broadcasts from [ForegroundOnlyLocationService].
     */
    private inner class ForegroundOnlyBroadcastReceiver : BroadcastReceiver() {

        override fun onReceive(context: Context, intent: Intent) {
            val location = intent.getParcelableExtra<Location>(
                MyNavigationService.EXTRA_LOCATION
            )

            if (location != null) {
                Toast.makeText(context, "Foreground location: ${location.toText()}", Toast.LENGTH_SHORT)
            }
        }
    }
}
