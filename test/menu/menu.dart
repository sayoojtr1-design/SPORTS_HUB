import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: MenuPage(), debugShowCheckedModeBanner: false));

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Menu'), backgroundColor: Colors.blue[100]),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('User'),
              accountEmail: Text('user@example.com'),
              currentAccountPicture: CircleAvatar(child: Icon(Icons.person)),
            ),
            ListTile(leading: const Icon(Icons.home), title: const Text('Home'), onTap: () => Navigator.pop(context)),
            ListTile(leading: const Icon(Icons.settings), title: const Text('Settings'), onTap: () => Navigator.pop(context)),
          ],
        ),
      ),
      body: const Center(child: Text('Open the drawer from the top-left')),
    );
  }
}
