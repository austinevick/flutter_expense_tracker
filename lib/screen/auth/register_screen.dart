import 'package:expense_tracker/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/app_colors.dart';
import '../../common/form_validation.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text.dart';
import '../../widget/custom_text_field.dart';
import 'auth_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (context, value, child) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Sign Up'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AutofillGroup(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      CustomTextfield(
                        controller: email,
                        autofillHints: [AutofillHints.email],
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => validateEmail(value!),
                      ),
                      SizedBox(height: 16),
                      CustomTextfield(
                        hintText: 'Password',
                        controller: password,
                        autofillHints: [AutofillHints.password],
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: showPassword,
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
                                .register(email.text, password.text)
                                .then((value) {
                              if (value.user != null) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (ctx) => HomeScreen()),
                                    (r) => true);
                              }
                            });
                          }
                        },
                        height: 50,
                        color: primaryColor,
                        child: ButtonLoader(
                            isLoading: value.isLoading, text: 'Register'),
                      ),
                      SizedBox(height: 10),
                      CustomButton(
                        height: 30,
                        onPressed: () => Navigator.pop(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText('Already have an account?',
                                paddingRight: 6),
                            CustomText('Sign in',
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
      );
    });
  }
}
