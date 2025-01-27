import 'package:expense_tracker/screen/auth/login_screen.dart';
import 'package:expense_tracker/screen/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'auth_view_model.dart';

class AuthStateNotifier extends StatelessWidget {
  const AuthStateNotifier({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
        builder: (context, value, child) => StreamBuilder<User?>(
            stream: value.authStateChanges,
            builder: (ctx, snapshot) =>
                snapshot.hasData ? HomeScreen() : LoginScreen()));
  }
}
