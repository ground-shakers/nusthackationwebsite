import 'package:flutter/material.dart';
import 'package:nusthackationwebsite/pages/dashboard.dart';
import 'package:nusthackationwebsite/pages/doctordashboard.dart';
import 'package:nusthackationwebsite/pages/landingpage.dart';
import 'package:nusthackationwebsite/services/storage_service.dart';
import 'package:nusthackationwebsite/services/doctor_storage_service.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  Future<String?> _getLoggedInRole() async {
    // Check doctor first
    final doctorData = await DoctorStorageService.getDoctorUserData();
    if (doctorData['token'] != null) {
      return doctorData['role']; // should be 'doctor'
    }

    // Check patient/user
    final userData = await StorageService.getUserData();
    if (userData['token'] != null) {
      return userData['role']; // could be 'patient' or something else
    }

    return null; // not logged in
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getLoggedInRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final role = snapshot.data;

        if (role == 'doctor') {
          return const DoctorDashboardPage();
        } else if (role != null) {
          return const Dashboard(); // patient/user
        } else {
          return const DesktopHome(); // not logged in
        }
      },
    );
  }
}
