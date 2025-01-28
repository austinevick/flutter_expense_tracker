import 'package:expense_tracker/screen/auth/auth_view_model.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final MockFirebaseAuth mockFirebaseAuth;
  late final AuthViewModel authViewModel;

  setUpAll(() {
    mockFirebaseAuth = MockFirebaseAuth();
    authViewModel = AuthViewModel(mockFirebaseAuth);
  });

  group("Register", () {
    test("Register with valid credentials", () async {
      final result = await authViewModel.register(
          "james.monroe@examplepetstore.com", "password");
      final user = result.user;
      expect(user, isNotNull);

      final uid = user?.uid;
      expect(uid, isA<String>());
    });

    test("Should return error message", () async {
      final result = await authViewModel.register(
          "james.monroe@examplepetstore.com","");
      final user = result.user;
      expect(user, isNull);

      final uid = user?.uid;
      expect(uid, isA<int>());
    });
  });
}
