import 'package:e_store/core/common/widgets/custom_button.dart';
import 'package:e_store/core/common/widgets/loading_dialog.dart';
import 'package:e_store/core/common/widgets/toast_helper.dart';
import 'package:e_store/features/authentication/view/home_screen.dart';
import 'package:e_store/features/authentication/view/login_screen.dart';
import 'package:e_store/features/authentication/view/widgets/custom_text_field.dart';
import 'package:e_store/features/authentication/view_model/auth_view_model.dart';
import 'package:e_store/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

   final emailCtr = TextEditingController();
   final passCtr = TextEditingController();
   final nameCtr = TextEditingController();
   final phoneCtr = TextEditingController();
   Future<void>signup () async{
     if (emailCtr.text.trim().isEmpty|| passCtr.text.trim().isEmpty){
       ToastHelper.show("Fill all the fields ");
       return;
     }
     final authViewModel = Provider.of<AuthViewModel>(context,listen:false);
     LoadingDialog.show(context);
     String result = await authViewModel.signup(
       email :emailCtr.text.trim(),
       password:passCtr.text.trim(),
     );
     if (!mounted) return;
     LoadingDialog.hide(context);
     if (result == "success") {
       ToastHelper.show("Sign up successful");
       Navigator.pushAndRemoveUntil(context,
         MaterialPageRoute(builder: (context) => RootScreen()),
             (route) => false,
       );
     }else{
       ToastHelper.show(result);
     }
   }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [

          const Text(
          "Create Account",
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

        const SizedBox(height: 10),

        const Text(
          "Create your account to get started.",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 30),

        // Full Name
        TextField(
          decoration: InputDecoration(
            hintText: "Full Name",
            prefixIcon: const Icon(Icons.person_outline),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Mobile Number
        TextField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: "Mobile Number",
            prefixIcon: const Icon(Icons.phone_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Email
        TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "Email Address",
            prefixIcon: const Icon(Icons.email_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Password
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: "Password",
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: const Icon(Icons.visibility_off),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Confirm Password
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: "Confirm Password",
            prefixIcon: const Icon(Icons.lock_reset_outlined),
            suffixIcon: const Icon(Icons.visibility_off),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        const SizedBox(height: 30),

        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.limeAccent,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: signup,
            child: const Text(
              "Register",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),

        const SizedBox(height: 30),

        Row(
          children: const [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text("OR"),
            ),
            Expanded(child: Divider()),
          ],
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.g_mobiledata),
                label: const Text("Google"),
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.apple),
                label: const Text("Apple"),
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Already have an account?",
              style: TextStyle(color: Colors.white70),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
              },
              child: const Text("Sign In"),
            ),
          ],
        ),

        const SizedBox(height: 20),
        ],
      )
    ),
    );



  }
}

