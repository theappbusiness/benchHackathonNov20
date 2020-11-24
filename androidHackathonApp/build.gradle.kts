plugins {
    id("com.android.application")
    kotlin("android")
    id("kotlin-android-extensions")
    id("kotlin-android")
    kotlin("kapt")
    id("dagger.hilt.android.plugin")
}
group = "com.kcc.kmmhackathon"
version = "1.0-SNAPSHOT"

repositories {
    gradlePluginPortal()
    google()
    jcenter()
    mavenCentral()
}

val recyclerVersion = "1.1.0"
val nav_version = "2.3.1"
val lifecycleVersion = "2.2.0"
val googlePlayServicesVersion = "17.0.0"

dependencies {

    // Our project modules
    implementation(project(":lib-find-meal"))
    implementation(project(":lib-theming"))

    // Shared multiplatform lib
    implementation(project(":shared"))

    // External dependencies
    implementation("com.google.android.material:material:1.2.0")
    implementation("androidx.appcompat:appcompat:1.2.0")
    implementation("androidx.constraintlayout:constraintlayout:1.1.3")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.3.9")
    implementation("androidx.core:core-ktx:1.3.1")
    implementation("androidx.recyclerview:recyclerview:$recyclerVersion")
    implementation("androidx.swiperefreshlayout:swiperefreshlayout:1.1.0")
    implementation("androidx.cardview:cardview:1.0.0")
    implementation("org.jetbrains.kotlin:kotlin-stdlib:${rootProject.extra["kotlin_version"]}")
    implementation("androidx.legacy:legacy-support-v4:1.0.0")
    implementation("androidx.lifecycle:lifecycle-livedata-ktx:$lifecycleVersion")
    implementation("androidx.lifecycle:lifecycle-viewmodel-ktx:$lifecycleVersion")
    implementation("androidx.navigation:navigation-fragment-ktx:$nav_version")
    implementation("androidx.navigation:navigation-ui-ktx:$nav_version")
    implementation("com.google.android.gms:play-services-maps:$googlePlayServicesVersion")
    implementation("com.google.android.gms:play-services-location:$googlePlayServicesVersion")

    // Hilt
    implementation("com.google.dagger:hilt-android:2.28-alpha")
    kapt("com.google.dagger:hilt-android-compiler:2.28-alpha")
    implementation("androidx.hilt:hilt-lifecycle-viewmodel:1.0.0-alpha02")
}

android {
    compileSdkVersion(30)
    defaultConfig {
        applicationId = "com.kcc.kmmhackathon.androidHackathonApp"
        minSdkVersion(24)
        targetSdkVersion(30)
        versionCode = 1
        versionName = "1.0"
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_1_8.toString()
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
        }
    }
}