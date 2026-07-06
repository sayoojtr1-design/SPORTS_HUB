import 'package:e_store/core/utils/theme/app_theme.dart';
import 'package:e_store/features/authentication/view/sign_up_screen.dart';
import 'package:e_store/providers/obscure_provider.dart';
import 'package:e_store/providers/theme_provider.dart';
import 'package:e_store/theme_demo_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => ObscureProvider())),
        ChangeNotifierProvider(create: ((context) => ThemeProvider()))
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder:(context,themeProvider, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            home: ThemeDemoPage(),
        );
      }
    );

  }
}
