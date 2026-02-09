#!/bin/bash

echo "=== Fixing ALL Plugin Issues ==="

# Function to add namespace and kotlinOptions if missing
fix_plugin() {
    local plugin_path="$1"
    local namespace="$2"
    local plugin_name="$3"
    
    if [ -f "$plugin_path" ]; then
        echo "Fixing $plugin_name..."
        
        # Backup
        cp "$plugin_path" "$plugin_path.backup"
        
        # Check if namespace exists
        if ! grep -q "namespace" "$plugin_path"; then
            sed -i "/^android {/a\    namespace '$namespace'" "$plugin_path"
            echo "  ✓ Added namespace"
        fi
        
        # Check if kotlinOptions exists
        if ! grep -q "kotlinOptions" "$plugin_path"; then
            # Add kotlinOptions after compileOptions block
            sed -i "/compileOptions {/,/}/a\\
\\
    kotlinOptions {\\
        jvmTarget = '1.8'\\
    }" "$plugin_path"
            echo "  ✓ Added kotlinOptions"
        fi
        
        # Ensure compileOptions exists
        if ! grep -q "compileOptions" "$plugin_path"; then
            sed -i "/compileSdkVersion/a\\
\\
    compileOptions {\\
        sourceCompatibility JavaVersion.VERSION_1_8\\
        targetCompatibility JavaVersion.VERSION_1_8\\
    }" "$plugin_path"
            echo "  ✓ Added compileOptions"
        fi
        
        echo "  ✓ $plugin_name fixed!"
    else
        echo "  ✗ $plugin_name not found at $plugin_path"
    fi
}

# Fix ar_flutter_plugin
fix_plugin \
    "/c/Users/sumit/AppData/Local/Pub/Cache/hosted/pub.dev/ar_flutter_plugin-0.7.3/android/build.gradle" \
    "io.carius.lars.ar_flutter_plugin" \
    "ar_flutter_plugin"

# Fix arcore_flutter_plugin
fix_plugin \
    "/c/Users/sumit/AppData/Local/Pub/Cache/hosted/pub.dev/arcore_flutter_plugin-0.1.0/android/build.gradle" \
    "com.difrancescogianmarco.arcore_flutter_plugin" \
    "arcore_flutter_plugin"

# Fix permission_handler_android (if it exists and is new version)
PERM_HANDLER=$(find "/c/Users/sumit/AppData/Local/Pub/Cache/hosted/pub.dev" -name "permission_handler_android-12*" -type d 2>/dev/null | head -1)
if [ -n "$PERM_HANDLER" ]; then
    fix_plugin \
        "$PERM_HANDLER/android/build.gradle" \
        "com.baseflow.permissionhandler" \
        "permission_handler_android"
fi

echo ""
echo "=== All plugins fixed! ==="
echo "Now running flutter clean and pub get..."

flutter clean
flutter pub get

echo ""
echo "=== Done! Try running: flutter run ==="
