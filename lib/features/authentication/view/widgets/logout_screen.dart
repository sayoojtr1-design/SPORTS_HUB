import 'package:flutter/material.dart';

class LogoutDialog {
  static Future<void> show({
    required BuildContext context,
    required VoidCallback onLogout
  }) async{
    await showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("LOg Out"),
        content: Text("Are you sure you wan to logout ?"),
        actions: [
          TextButton(onPressed: (){}, child: Text("Cancel")),
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
            onLogout;
          }, child: Text("Logout"))
        ],
      );
    });
  }
}
