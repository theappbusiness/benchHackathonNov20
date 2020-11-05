buildscript {
    repositories {
        gradlePluginPortal()
        jcenter()
        google()
        mavenCentral()
    }
    dependencies {
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.4.10")
        classpath("com.android.tools.build:gradle:4.1.0")
        classpath("org.jetbrains.kotlin:kotlin-serialization:1.4.0")
        classpath("com.google.gms:google-services:4.3.4")
    }
}
group = "com.kcc.kmmhackathon"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
    google()
}
