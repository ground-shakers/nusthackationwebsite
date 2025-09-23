import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nusthackationwebsite/pages/signuppage.dart';

class DesktopHome extends StatefulWidget {
  const DesktopHome({super.key});

  @override
  State<DesktopHome> createState() => _DesktopHomeState();
}

class _DesktopHomeState extends State<DesktopHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                  child: Text(
                    "Services",
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
                SizedBox(width: 20),
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
                      color: Color(0xFF009688),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Text(
                        "REGISTER",
                        style: TextStyle(
                          fontFamily: "Clarendon",
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Divider(color: Color(0xFF009688), thickness: 4),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: CarouselSlider(
                items: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: Image.asset(
                      'assets/images/doctors.png',
                      width: 1300,
                      height: 200.h,
                      alignment: Alignment(0, -0.3),
                      fit: BoxFit.cover,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: Image.asset(
                      'assets/images/doctors2.png',
                      width: 1300,
                      height: 200.h,
                      alignment: Alignment(0, -0.5),
                      fit: BoxFit.cover,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: Image.asset(
                      'assets/images/doctors3.png',
                      alignment: Alignment(0, -0.2),
                      width: 1300,
                      height: 200.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
                options: CarouselOptions(
                  height: 377,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  enlargeCenterPage: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  viewportFraction: 1,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 800,
                        child: Text(
                          "REVOLUTIONIZING HEALTHCARE, ONE CLICK AWAY",
                          style: TextStyle(
                            fontSize: 48,
                            height: 0.9,
                            fontFamily: "MontserratEBold",
                            color: const Color(0xFF009688),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 500,
                        child: Text(
                          "Access top-quality medical care without leaving your home. "
                          "Our platform connects you with doctors, specialists, and health services "
                          "instantly, making healthcare more convenient, reliable, and accessible than ever before.",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Clarendon",
                            color: Colors.black.withOpacity(0.6),
                            height: 1.4,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60),
                      Row(
                        children: [
                          _AnimatedCounter(count: 500, label: "Expert Doctors"),
                          const SizedBox(width: 40),
                          _AnimatedCounter(count: 20, label: "Patients"),
                          const SizedBox(width: 40),
                          _AnimatedCounter(
                            count: 100,
                            label: "Health Services",
                          ),
                        ],
                      ),
                      SizedBox(height: 80),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Our Partners",
                          style: TextStyle(
                            fontFamily: "MontserratEBold",
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/nustlogo.png",
                          width: 143,
                          height: 88,
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
    );
  }
}

class _AnimatedCounter extends StatefulWidget {
  final int count;
  final String label;

  const _AnimatedCounter({required this.count, required this.label});

  @override
  State<_AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<_AnimatedCounter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TweenAnimationBuilder<int>(
          tween: IntTween(begin: 0, end: widget.count),
          duration: const Duration(seconds: 2),
          builder: (context, value, child) {
            return Text(
              "$value+",
              style: const TextStyle(
                fontSize: 40,
                fontFamily: "ClarendonBold",
                color: Color(0xFF009688),
                height: 0.8,
              ),
            );
          },
        ),
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 16,
            fontFamily: "PoppinsM",
            color: const Color(0xFF009688).withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}
