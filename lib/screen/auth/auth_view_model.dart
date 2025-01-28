import 'package:expense_tracker/common/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuth auth;

  AuthViewModel(this.auth);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoadingState(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Stream<User?> get authStateChanges => auth.authStateChanges();

  Future<UserCredential> login(String email, String password) async {
    try {
      setLoadingState(true);
      final response = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (response.user != null) {
        simpleNotification('Login Successful', false);
      }
      setLoadingState(false);
      return response;
    } on FirebaseAuthException catch (e) {
      simpleNotification(e.message.toString(), true);
      setLoadingState(false);
      rethrow;
    } catch (e) {
      simpleNotification('Something went wrong', true);
      setLoadingState(false);
      rethrow;
    }
  }

  Future<UserCredential> register(String email, String password) async {
    try {
      setLoadingState(true);
      final response = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (response.user != null) {
        simpleNotification('Registration Successful', false);
      }
      setLoadingState(false);
      return response;
    } on FirebaseAuthException catch (e) {
      simpleNotification(e.message.toString(), true);
      setLoadingState(false);
      rethrow;
    } catch (e) {
      simpleNotification('Something went wrong', true);
      setLoadingState(false);
      rethrow;
    }
  }

  Future<void> logout() async => await auth.signOut();

}
