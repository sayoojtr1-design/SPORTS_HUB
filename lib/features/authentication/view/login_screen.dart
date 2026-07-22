
import 'package:e_store/core/common/widgets/loading_dialog.dart';
import 'package:e_store/core/common/widgets/toast_helper.dart';
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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),

                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.lightGreenAccent,
                        Colors.green.shade900,
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  "Welcome Back!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Sign in to continue",
                  style: TextStyle(color: Colors.grey.shade400),
                ),

                const SizedBox(height: 35),

                TextField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: Icon(Icons.visibility),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                Row(
                  children: [
                    Checkbox(value: false, onChanged: (_) {}),
                    const Text(
                      "Remember me",
                      style: TextStyle(color: Colors.white),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text("Forgot Password"),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.limeAccent,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: login,
                    child: const Text("login"),
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "OR",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.g_mobiledata),
                        label: Text("Google"),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.apple),
                        label: Text("Apple"),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white70),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (_) => LoginScreen(),

                      ),
                    );
                      },
                      child: const Text("Login",
                      style:TextStyle(
                        color: Color(0xffF58A42),
                        fontWeight: FontWeight.bold,
                      )
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
