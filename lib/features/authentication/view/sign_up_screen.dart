import 'package:e_store/features/authentication/view/login_screen.dart';
import 'package:e_store/providers/obscure_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final obProvider = Provider.of<ObscureProvider>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                labelText: "Email or Phone No",
                prefixIcon: Icon(Icons.email),
              ),
            ),
            TextField(
              obscureText: obProvider.isVisible,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                labelText: "password",
                prefixIcon: Icon(Icons.security),
                suffixIcon: IconButton(
                  onPressed: obProvider.toggleVisibility,
                  icon: Icon(
                    obProvider.isVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
