import kotlin.String
import org.gradle.plugin.use.PluginDependenciesSpec
import org.gradle.plugin.use.PluginDependencySpec

/**
 * Generated by https://github.com/jmfayard/buildSrcVersions
 *
 * Find which updates are available by running
 *     `$ ./gradlew buildSrcVersions`
 * This will only update the comments.
 *
 * YOU are responsible for updating manually the dependency version.
 */
object Versions {
    const val org_jetbrains_kotlinx_kotlinx_serialization: String = "1.0.0-RC"
             // available: "1.0.1"

    const val com_vanpra_compose_material_dialogs: String = "0.2.7"

    const val androidx_compose_material: String = "1.0.0-alpha08"

    const val com_google_android_gms: String = "17.0.0"

    const val org_jetbrains_kotlin: String = "1.4.20" // available: "1.4.21"

    const val androidx_navigation: String = "2.3.1" // available: "2.3.2"

    const val androidx_lifecycle: String = "2.2.0"

    const val com_google_dagger: String = "2.28-alpha"

    const val androidx_hilt: String = "1.0.0-alpha02"

    const val io_ktor: String = "1.4.0" // available: "1.4.3"

    const val com_google_android_material_material: String = "1.2.1"

    const val androidx_compose_compiler_compiler: String = "1.0.0-alpha08"

    const val com_android_tools_build_gradle: String = "7.0.0-alpha02"

    const val com_chromaticnoise_multiplatform_swiftpackage_gradle_plugin: String = "1.0.2"
             // available: "2.0.2"

    const val de_fayard_buildsrcversions_gradle_plugin: String = "0.7.0"

    const val kotlinx_coroutines_android: String = "1.3.9" // available: "1.4.2"

    const val kotlinx_coroutines_core: String = "1.3.9-native-mt" // available: "1.4.2"

    const val kotlinx_coroutines_test: String = "1.4.2"

    const val swiperefreshlayout: String = "1.1.0"

    const val legacy_support_v4: String = "1.0.0"

    const val constraintlayout: String = "2.0.4"

    const val fragment_ktx: String = "1.3.0-beta02"

    const val recyclerview: String = "1.1.0"

    const val lint_gradle: String = "27.3.0-alpha02"

    const val viewbinding: String = "7.0.0-alpha02"

    const val foundation: String = "1.0.0-alpha08"

    const val ui_tooling: String = "1.0.0-alpha07"

    const val appcompat: String = "1.2.0"

    const val cardview: String = "1.0.0"

    const val core_ktx: String = "1.3.2"

    const val junit: String = "4.12" // available: "4.13.1"

    const val mockk: String = "1.10.3-jdk8" // available: "1.10.3"

    const val uuid: String = "0.2.2" // available: "0.2.3"

    const val ui: String = "1.0.0-alpha08"

    /**
     * Current version: "6.7.1"
     * See issue 19: How to update Gradle itself?
     * https://github.com/jmfayard/buildSrcVersions/issues/19
     */
    const val gradleLatestVersion: String = "6.7.1"
}

/**
 * See issue #47: how to update buildSrcVersions itself
 * https://github.com/jmfayard/buildSrcVersions/issues/47
 */
val PluginDependenciesSpec.buildSrcVersions: PluginDependencySpec
    inline get() =
            id("de.fayard.buildSrcVersions").version(Versions.de_fayard_buildsrcversions_gradle_plugin)
