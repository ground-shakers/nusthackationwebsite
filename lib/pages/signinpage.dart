import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nusthackationwebsite/const/textfield.dart';
import 'package:nusthackationwebsite/models/auth_model.dart';
import 'package:nusthackationwebsite/pages/dashboard.dart';
import 'package:nusthackationwebsite/pages/signuppage.dart';
import 'package:nusthackationwebsite/services/api_service.dart';
import 'package:nusthackationwebsite/services/storage_service.dart';

class Signinpage extends StatefulWidget {
  const Signinpage({super.key});

  @override
  State<Signinpage> createState() => _SigninpageState();
}

class _SigninpageState extends State<Signinpage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all fields';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // 1. Create login request (NOT signup!)
      final loginRequest = LoginRequest(
        username: emailController.text,
        password: passwordController.text,
      );

      print('🔐 Attempting login...');
      print('📧 Email: ${emailController.text}');
      print('🔐 Password: ${passwordController.text}');

      // 2. Call the LOGIN API (not createPatient!)
      final loginResponse = await ApiService.login(loginRequest);

      // 3. Store the token and user data
      await StorageService.saveLoginData(loginResponse);

      // 4. Verify storage worked
      final userData = await StorageService.getUserData();
      print('💾 Stored user data: $userData');

      // 5. Show success and navigate to dashboard
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login successful!'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );
      }
    } catch (e) {
      print('❌ Login failed: $e');
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          CarouselSlider(
            items: [
              Image.asset(
                'assets/images/doctors.png',
                width: double.infinity,
                height: double.infinity,
                alignment: const Alignment(0, -0.3),
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/images/doctors2.png',
                width: double.infinity,
                height: double.infinity,
                alignment: const Alignment(0, -0.5),
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/images/doctors3.png',
                alignment: const Alignment(0, -0.2),
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ],
            options: CarouselOptions(
              height: double.infinity,
              autoPlay: true,
              aspectRatio: 16 / 9,
              enlargeCenterPage: true,
              autoPlayInterval: const Duration(seconds: 3),
              viewportFraction: 1,
            ),
          ),

          // Container
          Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              width: 900,
              height: 440,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    "LOGIN YOUR ACCOUNT",
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: "MontserratEBold",
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF009688),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Error message
                  if (_errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        _errorMessage,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  // ✅ FIXED: Use the state controller
                  EmailTextField(
                    controller: emailController,
                    hintText: "Email Address",
                  ),
                  const SizedBox(height: 6),

                  // ✅ FIXED: Use the state controller
                  PasswordTextField(
                    controller: passwordController,
                    hintText: "Password",
                  ),
                  const SizedBox(height: 40),

                  // ✅ FIXED: Removed duplicate GestureDetector
                  GestureDetector(
                    onTap: _isLoading ? null : _login,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _isLoading
                            ? Colors.grey
                            : const Color(0xFF009688),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF009688),
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text(
                                "LOG IN",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "MontserratEBold",
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "MontserratEBold",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: _isLoading
                            ? null
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Signuppage(),
                                  ),
                                );
                              },
                        child: Text(
                          " Sign Up",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "MontserratEBold",
                            fontWeight: FontWeight.bold,
                            color: _isLoading
                                ? Colors.grey
                                : const Color(0xFF009688),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
