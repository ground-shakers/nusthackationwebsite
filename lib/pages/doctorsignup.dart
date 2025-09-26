import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nusthackationwebsite/const/textfield.dart';
import 'package:nusthackationwebsite/models/doctors_model.dart';
import 'package:nusthackationwebsite/pages/doctordashboard.dart';
import 'package:nusthackationwebsite/pages/doctorlogin.dart';
import 'package:nusthackationwebsite/services/doctor_api_service.dart';
import 'package:nusthackationwebsite/services/doctor_storage_service.dart';

class Doctorsignup extends StatefulWidget {
  const Doctorsignup({super.key});

  @override
  State<Doctorsignup> createState() => _DoctorsignupState();
}

class _DoctorsignupState extends State<Doctorsignup> {
  // Personal Information Controllers
  final TextEditingController doctorFirstNameController =
      TextEditingController();
  final TextEditingController doctorLastNameController =
      TextEditingController();
  final TextEditingController doctorEmailController = TextEditingController();
  final TextEditingController doctorPhoneController = TextEditingController();
  final TextEditingController doctorPasswordController =
      TextEditingController();
  final TextEditingController doctorRetypePasswordController =
      TextEditingController();
  final TextEditingController doctorDobController = TextEditingController();
  final TextEditingController doctorGenderController = TextEditingController();

  // Professional Information Controllers
  final TextEditingController doctorIdNumberController =
      TextEditingController();
  final TextEditingController doctorSpecialtyController =
      TextEditingController();
  final TextEditingController doctorYearsExperienceController =
      TextEditingController();
  final TextEditingController doctorMedicalFacilityController =
      TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  bool get doctorPasswordsMatch {
    return doctorPasswordController.text == doctorRetypePasswordController.text;
  }

  bool get isDoctorFormValid {
    return doctorFirstNameController.text.isNotEmpty &&
        doctorLastNameController.text.isNotEmpty &&
        doctorEmailController.text.isNotEmpty &&
        doctorPhoneController.text.isNotEmpty &&
        doctorPasswordController.text.isNotEmpty &&
        doctorRetypePasswordController.text.isNotEmpty &&
        doctorGenderController.text.isNotEmpty &&
        doctorDobController.text.isNotEmpty &&
        doctorIdNumberController.text.isNotEmpty &&
        doctorSpecialtyController.text.isNotEmpty &&
        doctorYearsExperienceController.text.isNotEmpty &&
        doctorMedicalFacilityController.text.isNotEmpty &&
        doctorPasswordsMatch;
  }

  (int, int, int)? _parseDoctorDate(String dateString) {
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

  Future<void> _doctorSignUp() async {
    if (!isDoctorFormValid) {
      setState(() {
        _errorMessage = 'Please fill all fields correctly';
      });
      return;
    }

    if (!doctorPasswordsMatch) {
      setState(() {
        _errorMessage = 'Passwords do not match';
      });
      return;
    }

    final dateParts = _parseDoctorDate(doctorDobController.text);
    if (dateParts == null) {
      setState(() {
        _errorMessage = 'Please enter date in DD/MM/YYYY format';
      });
      return;
    }

    // Validate years of experience
    int? doctorYearsOfExperience;
    try {
      doctorYearsOfExperience = int.parse(doctorYearsExperienceController.text);
      if (doctorYearsOfExperience < 0) {
        setState(() {
          _errorMessage = 'Years of experience cannot be negative';
        });
        return;
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Please enter a valid number for years of experience';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // --- Create the DoctorSignupRequest object ---
      final doctorRequest = DoctorSignupRequest(
        contactInfo: DoctorContactInfo(
          email: doctorEmailController.text,
          phone: doctorPhoneController.text,
        ),
        password: doctorPasswordController.text,
        verifyPassword: doctorRetypePasswordController.text,
        firstName: doctorFirstNameController.text,
        lastName: doctorLastNameController.text,
        gender: doctorGenderController.text,
        birthDetails: DoctorBirthDetails(
          day: dateParts.$1,
          month: dateParts.$2,
          year: dateParts.$3,
        ),
        idNumber: doctorIdNumberController.text,
        specialty: doctorSpecialtyController.text
            .split(',')
            .map((s) => s.trim())
            .toList(),
        yearsOfExperience: doctorYearsOfExperience,
        medicalFacility: doctorMedicalFacilityController.text,
      );

      // --- Create doctor account ---
      final doctorSignupResponse = await DoctorApiService.createDoctor(
        doctorRequest,
      );
      print('✅ Doctor account created: ${doctorSignupResponse.message}');

      // --- Auto-login as form data ---
      print('🔄 Attempting doctor auto-login...');

      final loginBody = {
        'username': doctorEmailController.text,
        'password': doctorPasswordController.text,
      };
      print('📤 Sending doctor login request as form data: $loginBody');

      final response = await http.post(
        Uri.parse('https://ground-shakers.xyz/login'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: loginBody,
      );

      print('📥 Response code: ${response.statusCode}');
      print('📥 Response body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Doctor login failed: ${response.body}');
      }

      final responseData = jsonDecode(response.body);

      // --- Store the doctor token and user data ---
      await DoctorStorageService.saveDoctorLoginData(responseData);

      // Store doctor profile
      await DoctorStorageService.saveDoctorProfile(doctorSignupResponse.doctor);

      // Verify storage worked
      final doctorUserData = await DoctorStorageService.getDoctorUserData();
      final doctorProfile = await DoctorStorageService.getDoctorProfile();
      print('💾 Stored doctor user data: $doctorUserData');
      print('💾 Stored doctor profile: $doctorProfile');

      // Show success and navigate to dashboard
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Welcome Doctor! Account created successfully.'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DoctorDashboardPage()),
        );
      }
    } catch (e) {
      print('❌ Doctor signup/login failed: $e');
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
                      "CREATE A DOCTOR ACCOUNT",
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

                    if (isMobile)
                      _buildDoctorMobileForm()
                    else
                      _buildDoctorDesktopForm(),

                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: _isLoading ? null : _doctorSignUp,
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
                                  "SIGN UP AS DOCTOR",
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
                          "Already have a doctor account? ",
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
                                      builder: (context) => const Doctorlogin(),
                                    ),
                                  );
                                },
                          child: Text(
                            " Doctor Log In",
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

  Widget _buildDoctorDesktopForm() {
    return Column(
      children: [
        Text(
          "Personal Information",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: "MontserratEBold",
            color: const Color(0xFF009688),
          ),
        ),
        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserNameField(
              controller: doctorFirstNameController,
              hintText: "First Name",
            ),
            const SizedBox(width: 20),
            UserNameField(
              controller: doctorLastNameController,
              hintText: "Last Name",
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserNameField(
              controller: doctorEmailController,
              hintText: "Email Address",
            ),
            const SizedBox(width: 20),
            UserNameField(
              controller: doctorPhoneController,
              hintText: "Phone Number",
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PasswordTextField(
              controller: doctorPasswordController,
              hintText: "Password",
            ),
            const SizedBox(width: 20),
            PasswordTextField(
              controller: doctorRetypePasswordController,
              hintText: "Retype Password",
              doesMatch: doctorPasswordsMatch,
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
                controller: doctorGenderController,
                hintText: "Gender",
              ),
            ),
            const SizedBox(width: 20),
            DateOfBirthField(controller: doctorDobController),
          ],
        ),

        const SizedBox(height: 20),
        Text(
          "Professional Information",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: "MontserratEBold",
            color: const Color(0xFF009688),
          ),
        ),
        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserNameField(
              controller: doctorIdNumberController,
              hintText: "Medical ID Number",
            ),
            const SizedBox(width: 20),
            UserNameField(
              controller: doctorSpecialtyController,
              hintText: "Specialty (comma separated)",
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserNameField(
              controller: doctorYearsExperienceController,
              hintText: "Years of Experience",
            ),
            const SizedBox(width: 20),
            UserNameField(
              controller: doctorMedicalFacilityController,
              hintText: "Medical Facility/Hospital",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDoctorMobileForm() {
    return Column(
      children: [
        // Personal Information Section
        Text(
          "Personal Information",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF009688),
          ),
        ),
        const SizedBox(height: 10),

        UserNameField(
          controller: doctorFirstNameController,
          hintText: "First Name",
        ),
        const SizedBox(height: 10),
        UserNameField(
          controller: doctorLastNameController,
          hintText: "Last Name",
        ),
        const SizedBox(height: 10),
        UserNameField(
          controller: doctorEmailController,
          hintText: "Email Address",
        ),
        const SizedBox(height: 10),
        UserNameField(
          controller: doctorPhoneController,
          hintText: "Phone Number",
        ),
        const SizedBox(height: 10),
        PasswordTextField(
          controller: doctorPasswordController,
          hintText: "Password",
        ),
        const SizedBox(height: 10),
        PasswordTextField(
          controller: doctorRetypePasswordController,
          hintText: "Retype Password",
          doesMatch: doctorPasswordsMatch,
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 280,
          child: CustomDropdown(
            options: const ["Male", "Female", "Other"],
            controller: doctorGenderController,
            hintText: "Gender",
          ),
        ),
        const SizedBox(height: 10),
        DateOfBirthField(controller: doctorDobController),

        // Professional Information Section
        const SizedBox(height: 20),
        Text(
          "Professional Information",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF009688),
          ),
        ),
        const SizedBox(height: 10),

        UserNameField(
          controller: doctorIdNumberController,
          hintText: "Medical ID Number",
        ),
        const SizedBox(height: 10),
        UserNameField(
          controller: doctorSpecialtyController,
          hintText: "Specialty (comma separated)",
        ),
        const SizedBox(height: 10),
        UserNameField(
          controller: doctorYearsExperienceController,
          hintText: "Years of Experience",
        ),
        const SizedBox(height: 10),
        UserNameField(
          controller: doctorMedicalFacilityController,
          hintText: "Medical Facility/Hospital",
        ),
      ],
    );
  }

  @override
  void dispose() {
    doctorFirstNameController.dispose();
    doctorLastNameController.dispose();
    doctorEmailController.dispose();
    doctorPhoneController.dispose();
    doctorPasswordController.dispose();
    doctorRetypePasswordController.dispose();
    doctorDobController.dispose();
    doctorGenderController.dispose();
    doctorIdNumberController.dispose();
    doctorSpecialtyController.dispose();
    doctorYearsExperienceController.dispose();
    doctorMedicalFacilityController.dispose();
    super.dispose();
  }
}
