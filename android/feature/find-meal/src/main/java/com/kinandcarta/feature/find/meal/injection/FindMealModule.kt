package com.kinandcarta.feature.find.meal.injection

import android.content.Context
import com.google.android.gms.location.FusedLocationProviderClient
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ActivityComponent
import dagger.hilt.android.qualifiers.ActivityContext

@Module
@InstallIn(ActivityComponent::class)
class FindMealModule {

    companion object {
        @Provides
        fun provideFusedLocationClient(@ActivityContext context: Context) =
            FusedLocationProviderClient(context)
    }
}