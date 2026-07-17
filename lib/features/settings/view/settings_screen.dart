import 'package:e_store/features/settings/view/address_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../authentication/view/login_screen.dart';
import '../../orders/view/order_list_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  Future<void> _logout(BuildContext context) async {
    // Show confirmation dialog
    bool? confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Logout"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await FirebaseAuth.instance.signOut();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>  LoginScreen(),
        ),
            (route) => false,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings "),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Settings",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),

              Row(
                spacing: 5,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/image/Rowan-Atkinson-Mr-Bean.jpg"),
                  ),
                  Column(
                    crossAxisAlignment:CrossAxisAlignment.start ,
                    children: [
                      Text("sayooj",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Text("+91 8179118853",style: TextStyle(fontSize: 14,color: Colors.green),),
                    ],
                  ),

                ],
              ),
              SizedBox(height: 32),
              Text("Order History",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 8),

              Card(

                  child:Column(
                    children: [
                      Customprofileitem(icon: Icons.shopping_bag, title:'my orders',onTap:(){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>OrderListScreen()));
                      },)
                    ],
                  )

              ),
              SizedBox(height: 20,),
              Text("My Account",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 8),
              Card(
                child: Column(
                  children: [
                    Customprofileitem(icon: Icons.person_outline, title: 'Edit profile', onTap: (){ },),
                    Divider(),
                    Customprofileitem(icon: Icons.location_on_outlined,title: 'My Address',onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>AddressListScreen()));
                    },),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text("Help",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 8),
              Card(
                child:
                Customprofileitem(icon: Icons.info_outline, title: 'about', onTap: (){ },),
              ),


            ],

          ),));

  }
}

class Customprofileitem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const Customprofileitem({
    super.key, required this.icon, required this.title, required this.onTap,

  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}