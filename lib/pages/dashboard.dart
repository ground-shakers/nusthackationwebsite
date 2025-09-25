import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nusthackationwebsite/const/calender.dart';
import 'package:nusthackationwebsite/const/heartrategraph.dart';
import 'package:nusthackationwebsite/pages/chatbot.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    "MESMTF",
                    style: TextStyle(
                      fontSize: 40,
                      color: Color(0xFF009688),
                      fontFamily: "BalooPaajiR",
                    ),
                  ),
                ),
                SizedBox(width: 700.w),
                TextButton(
                  onPressed: () {},
                  child: Column(
                    children: [
                      Text(
                        "Dashboard",
                        style: TextStyle(
                          fontFamily: "Clarendon",
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChatbotPage()),
                    );
                  },
                  child: Text(
                    "Chatbot",
                    style: TextStyle(
                      fontFamily: "Clarendon",
                      fontSize: 16,
                      color: Color(0xFF009688),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "About Us",
                    style: TextStyle(
                      fontFamily: "Clarendon",
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Contact",
                    style: TextStyle(
                      fontFamily: "Clarendon",
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),

            // Main content (fades in)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  //Row 1
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "John Doe".toUpperCase(),
                                    style: TextStyle(
                                      fontFamily: "ClarendonBold",
                                      fontSize: 26,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "23 Years Old, Male",
                                    style: TextStyle(
                                      fontFamily: "MontserratEBold",
                                      fontSize: 14,
                                      height: 0.6,
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        width: 450.w,
                        height: 150.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFF009688),
                        ),
                        child: Center(
                          child: Text(
                            "Today is worse but tommorrow will be better",
                            style: TextStyle(
                              fontFamily: "MontserratEBold",
                              fontSize: 14,
                              height: 0.6,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        width: 450.w,
                        height: 150.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFF009688),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  //Row 2
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 450,
                          height: 500,
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
                                width: 380,
                                height: 380,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: CalendarPage(),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Column(
                          children: [
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
                                                fontFamily: "ClarendonBold",
                                                fontSize: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "HEALTY",
                                              style: TextStyle(
                                                fontFamily: "ClarendonBold",
                                                fontSize: 14,
                                                height: 0.6,
                                                color: Colors.white.withOpacity(
                                                  0.6,
                                                ),
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
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Average",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "ClarendonBold",
                                                        fontSize: 14,
                                                        height: 0.6,
                                                        color: Colors.white,
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
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Highest",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "ClarendonBold",
                                                        fontSize: 14,
                                                        height: 0.6,
                                                        color: Colors.white,
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
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Lowest",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "ClarendonBold",
                                                        fontSize: 14,
                                                        height: 0.6,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 40.h),

                                            SizedBox(
                                              width: 440,
                                              height: 100,
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
                                            color: Colors.white.withOpacity(
                                              0.6,
                                            ),
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
                                            color: Colors.white.withOpacity(
                                              0.6,
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
