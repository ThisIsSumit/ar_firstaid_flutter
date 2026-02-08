import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ar_firstaid_flutter/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: ARFirstAidApp()));

    // Wait for any async operations
    await tester.pumpAndSettle();

    // Verify that the app launched (this is a basic smoke test)
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
