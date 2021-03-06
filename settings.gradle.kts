pluginManagement {
    repositories {
        gradlePluginPortal()
        google()
        jcenter()
        mavenCentral()
    }
    resolutionStrategy {
        eachPlugin {
            if (requested.id.namespace == "com.android" || requested.id.name == "kotlin-android-extensions") {
                useModule("com.android.tools.build:gradle:4.0.1")
            }
        }
    }
}
rootProject.name = "KMMHackathon"

include(":android:app")
include(":android:lib:core")
include(":android:lib:theming")
include(":android:feature:find-meal")
include(":android:feature:add-meal")
include(":shared")
enableFeaturePreview("GRADLE_METADATA")
