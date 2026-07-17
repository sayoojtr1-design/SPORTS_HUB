

import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {

  final  FirebaseAuth auth = FirebaseAuth.instance;
  //signup
  Future<UserCredential> signUp({
    required String email,
    required String password,

}) async{
    return await auth. createUserWithEmailAndPassword(email: email,
        password: password);
    //login
  }
  Future<UserCredential>login({
    required String email,
    required String password,

}) async{
    return await auth. signInWithEmailAndPassword(email: email,
        password: password);

  }
  Future<void>logout() async{

    await auth.signOut();
  }
   User? currentUser(){
    return auth.currentUser;

   }

}
