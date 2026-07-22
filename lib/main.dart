import 'package:e_store/features/authentication/view/splash_screen.dart';
import 'package:e_store/features/authentication/view_model/auth_view_model.dart';
import 'package:e_store/features/cart/view_model/cart_view_model.dart';
import 'package:e_store/features/orders/view_model/checkout_View_model.dart';
import 'package:e_store/features/orders/view_model/order_view_model.dart';
import 'package:e_store/features/settings/view_model/address_view_model.dart';
import 'package:e_store/features/shop/view_model/product_view_model.dart';
import 'package:e_store/features/wishlist/view_model/wish_list_view_model.dart';
import 'package:e_store/providers/obscure_provider.dart';
import 'package:e_store/providers/theme_provider.dart';
import 'package:e_store/root_screen.dart';
import 'package:e_store/sample_api/todo_model.dart';
import 'package:e_store/sample_api/todo_screen.dart';
import 'package:e_store/sample_api/todo_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => ObscureProvider())),
        ChangeNotifierProvider(create: ((context) => ThemeProvider())),
        ChangeNotifierProvider(create: ((context) => AuthViewModel())),
        ChangeNotifierProvider(create: ((context) => AddressViewModel())),
        ChangeNotifierProvider(create: ((context) => TodoViewModel())),
        ChangeNotifierProvider(create: ((context) => ProductViewModel())),
        ChangeNotifierProvider(create: ((context) => CartViewModel())),
        ChangeNotifierProvider(create: ((context) => CheckoutViewModel())),
        ChangeNotifierProvider(create: ((context) => OrderViewModel())),
        ChangeNotifierProvider(create: (context){
          final  provider = WishListViewModel();
          provider.loadWishList();
          return provider;
  }),


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
            // theme: AppTheme.lightTheme,
            // darkTheme: AppTheme.darkTheme,
            // themeMode: themeProvider.themeMode,
            home: SplashScreen(),
        );
      }
    );

  }
}
