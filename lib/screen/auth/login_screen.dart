import 'package:expense_tracker/common/app_colors.dart';
import 'package:expense_tracker/common/form_validation.dart';
import 'package:expense_tracker/screen/auth/auth_view_model.dart';
import 'package:expense_tracker/screen/auth/register_screen.dart';
import 'package:expense_tracker/widget/custom_button.dart';
import 'package:expense_tracker/widget/custom_text.dart';
import 'package:expense_tracker/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, value, child) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Login'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: AutofillGroup(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      CustomTextfield(
                        controller: email,
                        autofillHints: [AutofillHints.email],
                        hintText: 'Email',
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) => validateEmail(value!),
                      ),
                      SizedBox(height: 16),
                      CustomTextfield(
                        controller: password,
                        autofillHints: [AutofillHints.password],
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: showPassword,
                        hintText: 'Password',
                        validator: (value) =>
                            value!.isEmpty ? 'Password is required' : null,
                        suffixIcon: IconButton(
                            onPressed: () =>
                                setState(() => showPassword = !showPassword),
                            icon: Icon(showPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined)),
                      ),
                      SizedBox(height: 25),
                      CustomButton(
                        isLoading: value.isLoading,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            value
                                .login(email.text, password.text)
                                .then((value) {
                              if (value.user != null) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (ctx) => HomeScreen()),
                                    (r) => false);
                              }
                            });
                          }
                        },
                        height: 50,
                        color: primaryColor,
                        child: ButtonLoader(
                            isLoading: value.isLoading, text: 'Login'),
                      ),
                      SizedBox(height: 10),
                      CustomButton(
                        height: 30,
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => RegisterScreen())),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText('Don\'t have an account?',
                                paddingRight: 6),
                            CustomText('Sign up',
                                color: primaryColor,
                                fontWeight: FontWeight.bold)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
