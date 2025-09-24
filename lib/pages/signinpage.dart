import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nusthackationwebsite/const/textfield.dart';

class Signuppage extends StatelessWidget {
  const Signuppage({super.key});

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
                alignment: Alignment(0, -0.3),
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/images/doctors2.png',
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment(0, -0.5),
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/images/doctors3.png',
                alignment: Alignment(0, -0.2),
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
                  SizedBox(height: 60),
                  const Text(
                    "LOGIN YOUR ACCOUNT",
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: "MontserratEBold",
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF009688),
                    ),
                  ),
                  const SizedBox(height: 40),
                  EmailTextField(
                    controller: TextEditingController(),
                    hintText: "Email Address",
                  ),
                  const SizedBox(height: 6),
                  PasswordTextField(
                    controller: TextEditingController(),
                    hintText: "Password",
                  ),
                  const SizedBox(height: 40),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF009688),
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
                      child: Text(
                        "LOG IN",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Clarendon",
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    "Already have an account? Sign Up",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: "MontserratEBold",
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
