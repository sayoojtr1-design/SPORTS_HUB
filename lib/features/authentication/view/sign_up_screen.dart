import 'package:e_store/core/common/widgets/custom_button.dart';
import 'package:e_store/core/common/widgets/loading_dialog.dart';
import 'package:e_store/core/common/widgets/toast_helper.dart';
import 'package:e_store/features/authentication/view/home_screen.dart';
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
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(ctr: nameCtr,
              hintText: "Enter Name",
              icon: Icons.person,
              obscure: false), CustomTextField(ctr: phoneCtr,
              hintText: "Enter Phone",
              icon: Icons.call,
              obscure: false), CustomTextField(ctr: emailCtr,
              hintText: "Enter Email",
              icon: Icons.email,
              obscure: false),
          CustomTextField(ctr: passCtr,
              hintText: "Enter password",
              icon: Icons.password,
              obscure: false),
          CustomButton(text: "Sign up", onTap: signup),
          Row(
            children: [

            ],
          )

        ],
      ),
      )
    );
  }
}

