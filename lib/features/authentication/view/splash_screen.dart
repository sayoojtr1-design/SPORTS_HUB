import 'package:e_store/features/authentication/view/login_screen.dart';
import 'package:e_store/features/authentication/view_model/auth_view_model.dart';
import 'package:e_store/features/shop/view/home_screen.dart';
import 'package:e_store/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  Future<void> checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));

    final authVm = Provider.of<AuthViewModel>(context, listen: false);

    if (!mounted) return;

    if (authVm.currentUser() != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => RootScreen()),
            (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Icon(Icons.shopping_cart, size: 100),),
    );
  }
}