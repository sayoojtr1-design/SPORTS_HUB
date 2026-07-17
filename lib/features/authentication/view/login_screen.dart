import 'package:e_store/core/common/widgets/custom_button.dart';
import 'package:e_store/core/common/widgets/loading_dialog.dart';
import 'package:e_store/core/common/widgets/toast_helper.dart';
import 'package:e_store/features/authentication/view/home_screen.dart';
import 'package:e_store/features/authentication/view/sign_up_screen.dart';
import 'package:e_store/features/authentication/view/widgets/custom_text_field.dart';
import 'package:e_store/features/authentication/view_model/auth_view_model.dart';
import 'package:e_store/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtr = TextEditingController();
  final passCtr = TextEditingController();
  final nameCtr = TextEditingController();
  final phoneCtr = TextEditingController();

  Future<void> login() async {
    if (emailCtr.text.trim().isEmpty || passCtr.text.trim().isEmpty) {
      ToastHelper.show("Fill all the fields ");
      return;
    }
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    LoadingDialog.show(context);
    String result = await authViewModel.login(
      email: emailCtr.text.trim(),
      password: passCtr.text.trim(),
    );
    if (!mounted) return;
    LoadingDialog.hide(context);
    if (result == "success") {
      ToastHelper.show("Login successful");
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => RootScreen()),
        (route) => false,
      );
    } else {
      ToastHelper.show(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              ctr: emailCtr,
              hintText: "Enter Email",
              icon: Icons.email,
              obscure: false,
            ),
            CustomTextField(
              ctr: passCtr,
              hintText: "Enter password",
              icon: Icons.password,
              obscure: false,
            ),
            CustomButton(text: "Login", onTap: login),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't Have an account ?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: Text("Sign Up"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
