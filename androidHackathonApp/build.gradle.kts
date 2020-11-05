plugins {
    id("com.android.application")
    kotlin("android")
    id("kotlin-android-extensions")
    id("com.google.gms.google-services")
}
group = "com.kcc.kmmhackathon"
version = "1.0-SNAPSHOT"

repositories {
    gradlePluginPortal()
    google()
    jcenter()
    mavenCentral()

}

val firebaseStoreVersion = "22.0.0"

dependencies {
    implementation(project(":shared"))
    implementation("com.google.android.material:material:1.2.0")
    implementation("androidx.appcompat:appcompat:1.2.0")
    implementation("androidx.constraintlayout:constraintlayout:1.1.3")
    implementation("com.google.firebase:firebase-firestore-ktx:$firebaseStoreVersion")
}

android {
    compileSdkVersion(29)
    defaultConfig {
        applicationId = "com.kcc.kmmhackathon.androidHackathonApp"
        minSdkVersion(24)
        targetSdkVersion(29)
        versionCode = 1
        versionName = "1.0"
    }
    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
        }
    }
}