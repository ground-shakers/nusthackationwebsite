import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nusthackationwebsite/const/textfield.dart';
import 'package:nusthackationwebsite/pages/codepage.dart';
import 'package:nusthackationwebsite/pages/signinpage.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypepasswordController =
      TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  bool get passwordsMatch {
    return passwordController.text == retypepasswordController.text;
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
                  SizedBox(height: 10),
                  const Text(
                    "CREATE AN ACCOUNT",
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: "MontserratEBold",
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF009688),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UserNameField(
                        controller: firstNameController,
                        hintText: "First Name",
                      ),
                      SizedBox(width: 20),
                      UserNameField(
                        controller: lastNameController,
                        hintText: "Last Name",
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UserNameField(
                        controller: usernameController,
                        hintText: "Username",
                      ),
                      SizedBox(width: 20),
                      EmailTextField(
                        controller: emailController,
                        hintText: "Email Address",
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PasswordTextField(
                        controller: passwordController,
                        hintText: "Password",
                      ),
                      SizedBox(width: 20),
                      PasswordTextField(
                        controller: retypepasswordController,
                        hintText: "Retype Password",
                        doesMatch: passwordsMatch,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomDropdown(
                        options: ["Male", "Female", "Other"],
                        controller: genderController,
                        hintText: "Gender",
                      ),
                      SizedBox(width: 20),
                      DateOfBirthField(controller: dobController),
                    ],
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Codepage(),
                        ),
                      );
                    },
                    child: Container(
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
                          "SIGN UP",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Clarendon",
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "MontserratEBold",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Signinpage(),
                            ),
                          );
                        },
                        child: const Text(
                          " Log In",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "MontserratEBold",
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF009688),
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
}
