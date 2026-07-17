import 'package:e_store/features/authentication/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthViewModel  extends ChangeNotifier{
  final AuthServices services = AuthServices();
  bool isLoading = false;

  //sign up
 Future<String>signup({
    required String email,
    required String password,
}) async{
   try{
     isLoading = true;
     notifyListeners();
     await services.signUp(email: email, password: password);
     isLoading = false;
     notifyListeners();
     return "success";
   }on FirebaseAuthException catch(e){
     isLoading = false;
     notifyListeners();
     return e.toString();

   }catch(e){
     isLoading = false;
     notifyListeners();
     return e.toString();
   }
 }
 //login
 Future<String>login({
    required String email,
    required String password,
})async{
   try{
     isLoading = true;
     notifyListeners();
     await services.login(email: email, password: password);
     isLoading = false;
     notifyListeners();
     return "success";

   }on FirebaseAuthException catch(e){
     isLoading = false;
     notifyListeners();
     return e.toString();
   } catch(e){
     isLoading = false;
     notifyListeners();
     return e.toString();
   }
 }
  Future<String>logout() async {
    try {
      isLoading = true;
      notifyListeners();
      await services.logout();
      isLoading = false;
      notifyListeners();
      return "success";
    } catch (e) {
      return e.toString();
    }


  }User? currentUser(){
   return services.currentUser();
  }

}