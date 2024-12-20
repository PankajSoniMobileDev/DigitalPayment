import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton; // Controls whether to show the back button

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton = false,
  }) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn'); // Clear login state
    Navigator.pushReplacementNamed(context, '/login'); // Navigate to Login
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop(); // Navigate back
        },
      )
          : null,
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            // Show confirmation dialog
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Logout'),
                content: const Text('Are you sure you want to log out?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context), // Close dialog
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                      _logout(context); // Perform logout
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}