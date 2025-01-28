import 'package:expense_tracker/screen/auth/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/custom_text.dart';
import '../currency/currency_converter_screen.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (context, viewModel, child) {
      return Drawer(backgroundColor: Colors.white,
          child: Column(
        children: [
          const SizedBox(height: 50),
          CircleAvatar(
            radius: 50,
            child: Icon(Icons.person, size: 50),
          ),
          const SizedBox(height: 20),
          CustomText("John Doe", fontSize: 20, fontWeight: FontWeight.w700),
          if (viewModel.auth.currentUser != null)
            CustomText(viewModel.auth.currentUser!.email ?? ''),
          const SizedBox(height: 20),
          ListTile(
              title: CustomText("Currency Converter"),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => CurrencyConverterScreen()));
              }),
          Spacer(),
          ListTile(
              title: CustomText("Logout",color: Colors.red),
              trailing: Icon(Icons.logout,color: Colors.red),
              onTap: () async => await viewModel.logout()),
          const SizedBox(height: 16),

        ],
      ));
    });
  }
}
