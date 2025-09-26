import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nusthackationwebsite/pages/doctorsignup.dart';
import 'package:nusthackationwebsite/pages/signinpage.dart';
import 'package:nusthackationwebsite/pages/signuppage.dart';

class Accounttype extends StatelessWidget {
  const Accounttype({super.key});

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
                  const SizedBox(height: 80),
                  const Text(
                    "SELECT YOUR ACCOUNT TYPE",
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: "MontserratEBold",
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF009688),
                    ),
                  ),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Signuppage(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF009688),
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                        child: Text(
                          "Patient",
                          style: TextStyle(
                            color: Color(0xFF009688),
                            fontFamily: "MontserratEBold",
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Doctorsignup(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF009688),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF009688),
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                        child: Text(
                          "Doctor",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "MontserratEBold",
                            fontSize: 16,
                          ),
                        ),
                      ),
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
