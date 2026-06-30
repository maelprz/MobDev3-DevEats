import 'package:deveats/viewmodels/auth_viewmodel.dart';
import 'package:deveats/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets("Verify Login Screen Widgets",
      (WidgetTester tester) async {

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AuthViewModel(),
        child: const MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );

    expect(find.text("Sign In →"), findsOneWidget);

    expect(find.byType(TextFormField), findsNWidgets(2));

    expect(find.byIcon(Icons.email_outlined), findsOneWidget);

    expect(find.byIcon(Icons.lock_outline), findsOneWidget);
  });
}