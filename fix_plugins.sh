# Fix ar_flutter_plugin
echo "Fixing ar_flutter_plugin..."
AR_PLUGIN="/c/Users/sumit/AppData/Local/Pub/Cache/hosted/pub.dev/ar_flutter_plugin-0.7.3/android/build.gradle"
if [ -f "$AR_PLUGIN" ]; then
    # Check if namespace already exists
    if ! grep -q "namespace" "$AR_PLUGIN"; then
        sed -i "/^android {/a\    namespace 'io.carius.lars.ar_flutter_plugin'" "$AR_PLUGIN"
        echo "✓ Fixed ar_flutter_plugin"
    fi
fi

# Fix arcore_flutter_plugin
echo "Fixing arcore_flutter_plugin..."
ARCORE_PLUGIN="/c/Users/sumit/AppData/Local/Pub/Cache/hosted/pub.dev/arcore_flutter_plugin-0.1.0/android/build.gradle"
if [ -f "$ARCORE_PLUGIN" ]; then
    if ! grep -q "namespace" "$ARCORE_PLUGIN"; then
        sed -i "/^android {/a\    namespace 'com.difrancescogianmarco.arcore_flutter_plugin'" "$ARCORE_PLUGIN"
        echo "✓ Fixed arcore_flutter_plugin"
    fi
fi

echo "All plugins fixed! Running flutter clean..."
flutter clean
flutter pub get