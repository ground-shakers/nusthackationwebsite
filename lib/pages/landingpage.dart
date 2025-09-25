// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nusthackationwebsite/const/animatetime.dart';
import 'package:nusthackationwebsite/const/textfield.dart';
import 'package:nusthackationwebsite/pages/signinpage.dart';
import 'package:visibility_detector/visibility_detector.dart';

class DesktopHome extends StatefulWidget {
  const DesktopHome({super.key});

  @override
  State<DesktopHome> createState() => _DesktopHomeState();
}

class _DesktopHomeState extends State<DesktopHome> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Header (always visible, no fade)
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
            FadeOnScrollWidget(
              child: Container(
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
            ),

            FadeOnScrollWidget(
              child: Padding(
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
                            AnimatedCounter(
                              count: 500,
                              label: "Expert Doctors",
                            ),
                            const SizedBox(width: 40),
                            AnimatedCounter(count: 20, label: "Patients"),
                            const SizedBox(width: 40),
                            AnimatedCounter(
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
            ),

            SizedBox(height: 100),

            FadeOnScrollWidget(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/hospitalbackground.png',
                    width: double.infinity,
                    height: 800,
                    alignment: Alignment(0, -0.3),
                    fit: BoxFit.cover,
                  ),

                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 100),
                        Text(
                          "OUR SERVICES",
                          style: TextStyle(
                            fontSize: 36,
                            height: 0.9,
                            fontFamily: "MontserratEBold",
                            color: Color(0xFF009688),
                          ),
                        ),
                        Text(
                          "Our Services Include many amazing services such as",
                          style: TextStyle(
                            fontSize: 14,
                            height: 0.9,
                            fontFamily: "Clarendon",
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 40),
                        Column(
                          children: [
                            SizedBox(
                              width: 400,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "24 Hour Support",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Clarendon",
                                      color: Color(0xFF009688),
                                      height: 1.4,
                                    ),
                                  ),
                                  Text(
                                    "24 Hour Support",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Clarendon",
                                      color: Color(0xFF009688),
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 400,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "24 Hour Support",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Clarendon",
                                      color: Color(0xFF009688),
                                      height: 1.4,
                                    ),
                                  ),
                                  Text(
                                    "24 Hour Support",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Clarendon",
                                      color: Color(0xFF009688),
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 400,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "24 Hour Support",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Clarendon",
                                      color: Color(0xFF009688),
                                      height: 1.4,
                                    ),
                                  ),
                                  Text(
                                    "24 Hour Support",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Clarendon",
                                      color: Color(0xFF009688),
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 400,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "24 Hour Support",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Clarendon",
                                      color: Color(0xFF009688),
                                      height: 1.4,
                                    ),
                                  ),
                                  Text(
                                    "24 Hour Support",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Clarendon",
                                      color: Color(0xFF009688),
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 400,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "24 Hour Support",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Clarendon",
                                      color: Color(0xFF009688),
                                      height: 1.4,
                                    ),
                                  ),
                                  Text(
                                    "24 Hour Support",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Clarendon",
                                      color: Color(0xFF009688),
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 400,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "24 Hour Support",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Clarendon",
                                      color: Color(0xFF009688),
                                      height: 1.4,
                                    ),
                                  ),
                                  Text(
                                    "24 Hour Support",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Clarendon",
                                      color: Color(0xFF009688),
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 120),
                        Text(
                          "CUSTOMER REVIEWS",
                          style: TextStyle(
                            fontSize: 36,
                            height: 0.9,
                            fontFamily: "MontserratEBold",
                            color: Color(0xFF009688),
                          ),
                        ),
                        Text(
                          "View the responses of other people that tried us",
                          style: TextStyle(
                            fontSize: 14,
                            height: 0.9,
                            fontFamily: "Clarendon",
                            color: Colors.black,
                          ),
                        ),

                        SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 200,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    Text(
                                      "Was an amazing Experience",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "Clarendon",
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    Text(
                                      "Was an amazing Experience",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "Clarendon",
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    Text(
                                      "Was an amazing Experience",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "Clarendon",
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    Text(
                                      "Was an amazing Experience",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "Clarendon",
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    Text(
                                      "Was an amazing Experience",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "Clarendon",
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
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
                ],
              ),
            ),

            SizedBox(height: 100),

            FadeOnScrollWidget(
              child: Column(
                children: [
                  Text(
                    "About Us",
                    style: TextStyle(
                      fontSize: 36,
                      height: 0.9,
                      fontFamily: "MontserratEBold",
                      color: Color(0xFF009688),
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Text(
                        "We are a company confused on this and that cause that is this",
                        style: TextStyle(
                          fontSize: 14,
                          height: 0.9,
                          fontFamily: "Clarendon",
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "We are a company confused on this and that cause that is this",
                        style: TextStyle(
                          fontSize: 14,
                          height: 0.9,
                          fontFamily: "Clarendon",
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "We are a company confused on this and that cause that is this",
                        style: TextStyle(
                          fontSize: 14,
                          height: 0.9,
                          fontFamily: "Clarendon",
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "We are a company confused on this and that cause that is this",
                        style: TextStyle(
                          fontSize: 14,
                          height: 0.9,
                          fontFamily: "Clarendon",
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "We are a company confused on this and that cause that is this",
                        style: TextStyle(
                          fontSize: 14,
                          height: 0.9,
                          fontFamily: "Clarendon",
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "We are a company confused on this and that cause that is this",
                        style: TextStyle(
                          fontSize: 14,
                          height: 0.9,
                          fontFamily: "Clarendon",
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "We are a company confused on this and that cause that is this",
                        style: TextStyle(
                          fontSize: 14,
                          height: 0.9,
                          fontFamily: "Clarendon",
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "We are a company confused on this and that cause that is this",
                        style: TextStyle(
                          fontSize: 14,
                          height: 0.9,
                          fontFamily: "Clarendon",
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "We are a company confused on this and that cause that is this",
                        style: TextStyle(
                          fontSize: 14,
                          height: 0.9,
                          fontFamily: "Clarendon",
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "We are a company confused on this and that cause that is this",
                        style: TextStyle(
                          fontSize: 14,
                          height: 0.9,
                          fontFamily: "Clarendon",
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "We are a company confused on this and that cause that is this",
                        style: TextStyle(
                          fontSize: 14,
                          height: 0.9,
                          fontFamily: "Clarendon",
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "We are a company confused on this and that cause that is this",
                        style: TextStyle(
                          fontSize: 14,
                          height: 0.9,
                          fontFamily: "Clarendon",
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 200),
                ],
              ),
            ),

            SizedBox(height: 100),

            FadeOnScrollWidget(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/thinkingdoctor.png',
                    width: double.infinity,
                    height: 800,
                    alignment: Alignment(0, -0.3),
                    fit: BoxFit.cover,
                  ),

                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 300),
                        Text(
                          "CONTACT US",
                          style: TextStyle(
                            fontSize: 36,
                            height: 0.9,
                            fontFamily: "MontserratEBold",
                            color: Color(0xFF009688),
                          ),
                        ),
                        SizedBox(height: 40),
                        EmailTextField(
                          controller: TextEditingController(),
                          hintText: "Your Email",
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: 280,
                          child: TextField(
                            maxLines: 5,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: "Your Message",
                              hintStyle: TextStyle(
                                color: Color(0xFF009688),
                                fontFamily: 'ClarendonBold',
                                fontSize: 14,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF009688),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF009688),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 24,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              height: 0.9,
                              fontFamily: 'Clarendon',
                              color: Color(0xFF009688),
                            ),
                          ),
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
                              "SIGN UP",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Clarendon",
                                fontSize: 12,
                              ),
                            ),
                          ),
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

class FadeOnScrollWidget extends StatefulWidget {
  final Widget child;
  final double fadeOffset;

  const FadeOnScrollWidget({
    Key? key,
    required this.child,
    this.fadeOffset = 100.0,
  }) : super(key: key);

  @override
  State<FadeOnScrollWidget> createState() => _FadeOnScrollWidgetState();
}

class _FadeOnScrollWidgetState extends State<FadeOnScrollWidget> {
  double _opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('${widget.child.hashCode}'),
      onVisibilityChanged: (VisibilityInfo info) {
        final visibleFraction = info.visibleFraction;

        double newOpacity;
        if (visibleFraction > 0.1) {
          newOpacity = (visibleFraction - 0.05) * 4;
        } else {
          newOpacity = visibleFraction * 4;
        }

        newOpacity = newOpacity.clamp(0.0, 1.0);

        if (_opacity != newOpacity) {
          setState(() {
            _opacity = newOpacity;
          });
        }
      },
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: Duration(milliseconds: 200),
        child: widget.child,
      ),
    );
  }
}
