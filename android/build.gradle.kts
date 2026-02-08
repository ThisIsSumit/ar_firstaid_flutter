allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

val arcoreManifestFile = file(
    "${System.getProperty("user.home")}/AppData/Local/Pub/Cache/hosted/pub.dev/arcore_flutter_plugin-0.1.0/android/src/main/AndroidManifest.xml"
)

tasks.register("patchArcoreManifest") {
    doLast {
        if (arcoreManifestFile.exists()) {
            val original = arcoreManifestFile.readText()
            val patched = original.replace(Regex("""\s*package="[^"]*""""), "")
            if (original != patched) {
                arcoreManifestFile.writeText(patched)
            }
        }
    }
}

