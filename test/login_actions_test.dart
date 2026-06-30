import 'package:deveats/viewmodels/auth_viewmodel.dart';
import 'package:deveats/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {

  testWidgets(
      "Enter Email Password Press Login",
      (WidgetTester tester) async {

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AuthViewModel(),
        child: const MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );

    await tester.enterText(
      find.byType(TextFormField).at(0),
      "john@gmail.com",
    );

    await tester.enterText(
      find.byType(TextFormField).at(1),
      "password123",
    );

    expect(find.text("john@gmail.com"), findsOneWidget);

    expect(find.text("password123"), findsOneWidget);

    // Don't actually tap the button.
    expect(find.text("Sign In →"), findsOneWidget);

  });

}