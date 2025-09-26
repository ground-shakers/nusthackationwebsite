import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nusthackationwebsite/const/calender.dart';
import 'package:nusthackationwebsite/const/heartrategraph.dart';
import 'package:nusthackationwebsite/pages/chatbot.dart';
import 'package:nusthackationwebsite/pages/contactus.dart';
import 'package:nusthackationwebsite/pages/profile.dart';
import 'package:nusthackationwebsite/services/api_service.dart';
import 'package:nusthackationwebsite/services/storage_service.dart';
import 'package:nusthackationwebsite/models/patient_model.dart';
import 'package:text_scroll/text_scroll.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Patient? _patient;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadPatientData();
  }

  Future<void> _loadPatientData() async {
    try {
      final token = await StorageService.getAccessToken();
      final userId = await StorageService.getUserId();

      if (token == null || userId == null) {
        throw Exception('User not authenticated');
      }

      print('🔍 Loading patient data for ID: $userId');

      // Fetch patient data from API
      final patient = await ApiService.getPatientProfile(userId, token);

      setState(() {
        _patient = patient;
        _isLoading = false;
      });

      print('✅ Patient data loaded: ${patient.firstName} ${patient.lastName}');
    } catch (e) {
      print('❌ Error loading patient data: $e');
      setState(() {
        _errorMessage = 'Failed to load patient data';
        _isLoading = false;
      });
    }
  }

  // Age Calculation
  int _calculateAge() {
    if (_patient == null) return 0;

    try {
      final now = DateTime.now();
      final birthDate = DateTime(
        _patient!.birthDetails.year,
        _patient!.birthDetails.month,
        _patient!.birthDetails.day,
      );

      // Validate that birthdate is not in the future
      if (birthDate.isAfter(now)) return 0;

      int age = now.year - birthDate.year;

      // Adjust age if birthday hasn't occurred yet this year
      if (now.month < birthDate.month ||
          (now.month == birthDate.month && now.day < birthDate.day)) {
        age--;
      }

      return age;
    } catch (e) {
      // Handle potential DateTime exceptions
      return 0;
    }
  }

  // Gender Formatting
  String _formatGender() {
    if (_patient == null) return '';
    return _patient!.gender[0].toUpperCase() + _patient!.gender.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "MESMTF",
                      style: TextStyle(
                        fontSize: 40,
                        color: Color(0xFF009688),
                        fontFamily: "BalooPaajiR",
                      ),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Dashboard(),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Text(
                          "Dashboard",
                          style: TextStyle(
                            fontFamily: "Clarendon",
                            fontSize: 16,
                            color: Color(0xFF009688),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChatbotPage(userId: _patient!.id),
                        ),
                      );
                    },
                    child: Text(
                      "AI Diagnosis",
                      style: TextStyle(
                        fontFamily: "Clarendon",
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Contactus(userId: _patient!.id),
                        ),
                      );
                    },
                    child: Text(
                      "Contact",
                      style: TextStyle(
                        fontFamily: "Clarendon",
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfilePage(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF009688),
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Text(
                            "GO TO ACCOUNT",
                            style: TextStyle(
                              fontFamily: "Clarendon",
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),

            // Main content
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : _errorMessage.isNotEmpty
                ? Center(child: Text(_errorMessage))
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //User Info Card
                            Container(
                              width: 450.w,
                              height: 150.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0xFF009688),
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 100.w,
                                      height: 100.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(
                                            "assets/images/nustlogo.png",
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20.w),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 300,
                                          child: TextScroll(
                                            "${_patient!.firstName} ${_patient!.lastName}"
                                                .toUpperCase(),
                                            velocity: Velocity(
                                              pixelsPerSecond: Offset(20, 0),
                                            ),
                                            intervalSpaces: 10,
                                            delayBefore: Duration(seconds: 1),
                                            style: TextStyle(
                                              fontFamily: "ClarendonBold",
                                              fontSize: 26,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${_calculateAge()} Years Old, ${_formatGender()}",
                                          style: TextStyle(
                                            fontFamily: "MontserratEBold",
                                            fontSize: 14,
                                            height: 0.6,
                                            color: Colors.white.withOpacity(
                                              0.6,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          _patient!.contactInfo.email,
                                          style: TextStyle(
                                            fontFamily: "MontserratEBold",
                                            fontSize: 12,
                                            color: Colors.white.withOpacity(
                                              0.8,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Motivation Card
                            Container(
                              width: 450.w,
                              height: 150.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0xFF009688),
                              ),
                              child: Center(
                                child: Text(
                                  "The greatest wealth is health",
                                  style: TextStyle(
                                    fontFamily: "MontserratEBold",
                                    fontSize: 14,
                                    height: 0.6,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            // Additional Info Card
                            Container(
                              width: 450.w,
                              height: 150.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0xFF009688),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Patient ID:",
                                          style: TextStyle(
                                            fontFamily: "MontserratEBold",
                                            fontSize: 14,
                                            height: 0.6,
                                            color: Colors.white.withOpacity(
                                              0.8,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "${_patient!.id.substring(0, 12)}...",
                                          style: TextStyle(
                                            fontFamily: "ClarendonBold",
                                            fontSize: 24,
                                            height: 1,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Phone: ${_patient!.contactInfo.phone}",
                                          style: TextStyle(
                                            fontFamily: "MontserratEBold",
                                            fontSize: 14,
                                            height: 0.6,
                                            color: Colors.white.withOpacity(
                                              0.8,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20.h),

                        // Rest of your dashboard content (unchanged)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 450.w,
                                height: 740.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color(0xFF009688),
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    const Text(
                                      "Next Appointment is in",
                                      style: TextStyle(
                                        fontFamily: "ClarendonBold",
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Text(
                                      "3 DAYS",
                                      style: TextStyle(
                                        fontFamily: "ClarendonBold",
                                        fontSize: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 380.w,
                                      height: 580.h,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: CalendarPage(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Health metrics column
                              Column(
                                children: [
                                  // Heart Rate Container
                                  Container(
                                    width: 880.w,
                                    height: 420.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color(0xFF009688),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 20,
                                                right: 40,
                                                left: 20,
                                              ),
                                              child: Lottie.asset(
                                                'assets/animations/Heart.json',
                                                width: 150,
                                                height: 150,
                                                repeat: true,
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 20.h),
                                                  Text(
                                                    "Heart Rate",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "ClarendonBold",
                                                      fontSize: 30,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    "HEALTHY",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "ClarendonBold",
                                                      fontSize: 14,
                                                      height: 0.6,
                                                      color: Colors.white
                                                          .withOpacity(0.6),
                                                    ),
                                                  ),
                                                  SizedBox(height: 20.h),
                                                  Row(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(
                                                            "76",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "ClarendonBold",
                                                              fontSize: 40,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Average",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "ClarendonBold",
                                                              fontSize: 14,
                                                              height: 0.6,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 40.w),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            "82",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "ClarendonBold",
                                                              fontSize: 40,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Highest",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "ClarendonBold",
                                                              fontSize: 14,
                                                              height: 0.6,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 40.w),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            "72",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "ClarendonBold",
                                                              fontSize: 40,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Lowest",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "ClarendonBold",
                                                              fontSize: 14,
                                                              height: 0.6,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 40.h),
                                                  SizedBox(
                                                    width: 440.w,
                                                    height: 100.h,
                                                    child: HeartRateChart(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20.h),

                                  // Menstrual Cycle Container
                                  Container(
                                    width: 880.w,
                                    height: 300.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color(0xFF009688),
                                    ),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 20,
                                              right: 40,
                                              left: 20,
                                            ),
                                            child: Lottie.asset(
                                              'assets/animations/Blood.json',
                                              width: 150,
                                              height: 150,
                                              repeat: true,
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Menstrual Cycle Tracking",
                                                style: TextStyle(
                                                  fontFamily: "ClarendonBold",
                                                  fontSize: 30,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "Next Period in",
                                                style: TextStyle(
                                                  fontFamily: "ClarendonBold",
                                                  fontSize: 14,
                                                  height: 0.6,
                                                  color: Colors.white
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                              SizedBox(height: 20.h),
                                              Text(
                                                "12 Days",
                                                style: TextStyle(
                                                  fontFamily: "ClarendonBold",
                                                  fontSize: 40,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(height: 20.h),
                                              Text(
                                                "High Chance of getting Pregnant",
                                                style: TextStyle(
                                                  fontFamily: "ClarendonBold",
                                                  fontSize: 14,
                                                  height: 0.6,
                                                  color: Colors.white
                                                      .withOpacity(0.6),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
