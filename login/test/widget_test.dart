import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login/main.dart';

void main() {
  testWidgets('Login page widgets test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget( MyApp());

    // Verify that username and password text fields exist.
    expect(find.byType(TextField), findsNWidgets(2));

    // Enter text into username and password fields.
    await tester.enterText(find.byType(TextField).first, 'admin');
    await tester.enterText(find.byType(TextField).last, 'admin');

    // Tap on the login button.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify that after tapping login button, it navigates to home page.
    expect(find.text('Home Page'), findsOneWidget);
  });
}

class LoginApp {
}
