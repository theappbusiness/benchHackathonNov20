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

include(":androidHackathonApp")
include(":lib-theming")
include(":feature-find-meal")
include(":feature-add-meal")
include(":shared")
enableFeaturePreview("GRADLE_METADATA")
