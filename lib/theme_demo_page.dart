import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class ThemeDemoPage extends StatelessWidget {
  const ThemeDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Theme Demo"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Theme Switching",
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.dark_mode),
                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        "Dark Mode",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),

                    Switch(
                      value: themeProvider.isDark,
                      onChanged: (value) {
                        themeProvider.toggleTheme(value);
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            Text(
              themeProvider.isDark
                  ? "Dark Theme Enabled"
                  : "Light Theme Enabled",
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {},
              child: const Text("Sample Button"),
            ),

            const SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                labelText: "Name",
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}