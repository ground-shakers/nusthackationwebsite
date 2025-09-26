import 'package:flutter/material.dart';
import 'package:nusthackationwebsite/pages/dashboard.dart';
import 'package:nusthackationwebsite/pages/landingpage.dart';
import 'package:nusthackationwebsite/services/storage_service.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StorageService.isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final isLoggedIn = snapshot.data ?? false;

        if (isLoggedIn) {
          return const Dashboard();
        } else {
          return const DesktopHome();
        }
      },
    );
  }
}
