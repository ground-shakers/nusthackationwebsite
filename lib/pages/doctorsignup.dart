import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nusthackationwebsite/const/textfield.dart';
import 'package:nusthackationwebsite/models/auth_model.dart';
import 'package:nusthackationwebsite/models/patient_model.dart';
import 'package:nusthackationwebsite/pages/dashboard.dart';
import 'package:nusthackationwebsite/services/api_service.dart';
import 'package:nusthackationwebsite/pages/signinpage.dart';
import 'package:nusthackationwebsite/services/storage_service.dart';

class Doctorsignup extends StatefulWidget {
  const Doctorsignup({super.key});

  @override
  State<Doctorsignup> createState() => _DoctorsignupState();
}

class _DoctorsignupState extends State<Doctorsignup> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypepasswordController =
      TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  bool get passwordsMatch {
    return passwordController.text == retypepasswordController.text;
  }

  bool get isFormValid {
    return firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        retypepasswordController.text.isNotEmpty &&
        genderController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        passwordsMatch;
  }

  // Parse date from "DD/MM/YYYY" format
  (int, int, int)? _parseDate(String dateString) {
    try {
      final parts = dateString.split('/');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        return (day, month, year);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<void> _signUp() async {
    if (!isFormValid) {
      setState(() {
        _errorMessage = 'Please fill all fields correctly';
      });
      return;
    }

    if (!passwordsMatch) {
      setState(() {
        _errorMessage = 'Passwords do not match';
      });
      return;
    }

    final dateParts = _parseDate(dobController.text);
    if (dateParts == null) {
      setState(() {
        _errorMessage = 'Please enter date in DD/MM/YYYY format';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // 1. Create the PatientSignupRequest object
      final request = PatientSignupRequest(
        contactInfo: ContactInfo(
          email: emailController.text,
          phone: phoneController.text,
        ),
        password: passwordController.text,
        verifyPassword: retypepasswordController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        gender: genderController.text,
        birthDetails: BirthDetails(
          day: dateParts.$1,
          month: dateParts.$2,
          year: dateParts.$3,
        ),
      );

      // 2. Create account
      final signupResponse = await ApiService.createPatient(request);
      print('✅ Account created: ${signupResponse.message}');

      // 3. Auto-login with the same credentials
      final loginRequest = LoginRequest(
        username: emailController.text,
        password: passwordController.text,
      );

      print('🔄 Attempting auto-login...');
      final loginResponse = await ApiService.login(loginRequest);

      // 4. Store the token and user data
      await StorageService.saveLoginData(loginResponse);

      // 5. Verify storage worked
      final userData = await StorageService.getUserData();
      print('💾 Stored user data: $userData');

      // 6. Show success and navigate to dashboard
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Welcome! Login successful.'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );
      }
    } catch (e) {
      print('❌ Signup/login failed: $e');
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(24),
                width: isMobile ? double.infinity : 900,
                constraints: BoxConstraints(maxWidth: isMobile ? 500 : 900),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "CREATE AN ACCOUNT",
                      style: TextStyle(
                        fontSize: isMobile ? 22 : 26,
                        fontFamily: "MontserratEBold",
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF009688),
                      ),
                      textAlign: TextAlign.center,
                    ),

                    // Error message
                    if (_errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          _errorMessage,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                    const SizedBox(height: 10),

                    if (isMobile) _buildMobileForm() else _buildDesktopForm(),

                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: _isLoading ? null : _signUp,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _isLoading
                              ? Colors.grey
                              : const Color(0xFF009688),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _isLoading
                                ? Colors.grey
                                : const Color(0xFF009688),
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 20 : 30,
                            vertical: isMobile ? 12 : 10,
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : Text(
                                  "SIGN UP",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Clarendon",
                                    fontSize: isMobile ? 11 : 12,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontSize: isMobile ? 11 : 12,
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
                                      builder: (context) => const Signinpage(),
                                    ),
                                  );
                                },
                          child: Text(
                            " Log In",
                            style: TextStyle(
                              fontSize: isMobile ? 11 : 12,
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
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopForm() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserNameField(
              controller: firstNameController,
              hintText: "First Name",
            ),
            const SizedBox(width: 20),
            UserNameField(
              controller: lastNameController,
              hintText: "Last Name",
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserNameField(
              controller: emailController,
              hintText: "Email Address",
            ),
            const SizedBox(width: 20),
            UserNameField(
              controller: phoneController,
              hintText: "Phone Number",
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PasswordTextField(
              controller: passwordController,
              hintText: "Password",
            ),
            const SizedBox(width: 20),
            PasswordTextField(
              controller: retypepasswordController,
              hintText: "Retype Password",
              doesMatch: passwordsMatch,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 280,
              child: CustomDropdown(
                options: const ["Male", "Female", "Other"],
                controller: genderController,
                hintText: "Gender",
              ),
            ),
            const SizedBox(width: 20),
            DateOfBirthField(controller: dobController),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileForm() {
    return Column(
      children: [
        UserNameField(controller: firstNameController, hintText: "First Name"),
        const SizedBox(height: 10),
        UserNameField(controller: lastNameController, hintText: "Last Name"),
        const SizedBox(height: 10),
        UserNameField(controller: emailController, hintText: "Email Address"),
        const SizedBox(height: 10),
        UserNameField(controller: phoneController, hintText: "Phone Number"),
        const SizedBox(height: 10),
        PasswordTextField(controller: passwordController, hintText: "Password"),
        const SizedBox(height: 10),
        PasswordTextField(
          controller: retypepasswordController,
          hintText: "Retype Password",
          doesMatch: passwordsMatch,
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 280,
          child: CustomDropdown(
            options: const ["Male", "Female", "Other"],
            controller: genderController,
            hintText: "Gender",
          ),
        ),
        const SizedBox(height: 10),
        DateOfBirthField(controller: dobController),
      ],
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    retypepasswordController.dispose();
    dobController.dispose();
    genderController.dispose();
    super.dispose();
  }
}
