import 'package:flutter_test/flutter_test.dart';
import 'package:deveats/utils/validators.dart';

void main() {
  group("Email Validation Tests", () {

    test("Valid email", () {
      expect(
        Validators.isValidEmail("john@gmail.com"),
        true,
      );
    });

    test("Invalid email", () {
      expect(
        Validators.isValidEmail("john@gmail"),
        false,
      );
    });

    test("Empty email", () {
      expect(
        Validators.isValidEmail(""),
        false,
      );
    });

  });
}