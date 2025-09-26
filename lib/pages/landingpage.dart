// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nusthackationwebsite/const/animatetime.dart';
import 'package:nusthackationwebsite/const/textfield.dart';
import 'package:nusthackationwebsite/pages/accounttype.dart';
import 'package:visibility_detector/visibility_detector.dart';

class DesktopHome extends StatefulWidget {
  const DesktopHome({super.key});

  @override
  State<DesktopHome> createState() => _DesktopHomeState();
}

class _DesktopHomeState extends State<DesktopHome> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _aboutUsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _showScrollToTop = _scrollController.offset > 400;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
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
                  child: SafeArea(
                    child: isMobile
                        ? _buildMobileHeader()
                        : _buildDesktopHeader(),
                  ),
                ),

                // Carousel Section
                FadeOnScrollWidget(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: CarouselSlider(
                      items: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(26),
                          child: Image.asset(
                            'assets/images/doctors.png',
                            width: double.infinity,
                            height: isMobile ? 200 : 377,
                            alignment: Alignment(0, -0.3),
                            fit: BoxFit.cover,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(26),
                          child: Image.asset(
                            'assets/images/doctors2.png',
                            width: double.infinity,
                            height: isMobile ? 200 : 377,
                            alignment: Alignment(0, -0.5),
                            fit: BoxFit.cover,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(26),
                          child: Image.asset(
                            'assets/images/doctors3.png',
                            alignment: Alignment(0, -0.2),
                            width: double.infinity,
                            height: isMobile ? 200 : 377,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                      options: CarouselOptions(
                        height: isMobile ? 200 : 377,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        enlargeCenterPage: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        viewportFraction: 1,
                      ),
                    ),
                  ),
                ),

                // Main Content Section
                FadeOnScrollWidget(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: isMobile
                        ? _buildMobileContent()
                        : _buildDesktopContent(),
                  ),
                ),

                const SizedBox(height: 100),

                // Services Section
                Container(
                  key: _servicesKey,
                  child: FadeOnScrollWidget(
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/images/hospitalbackground.png',
                          width: double.infinity,
                          height: isMobile ? 600 : 800,
                          alignment: Alignment(0, -0.3),
                          fit: BoxFit.cover,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: isMobile
                                ? _buildMobileServices()
                                : _buildDesktopServices(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 100),

                // About Us Section
                Container(
                  key: _aboutUsKey,
                  child: FadeOnScrollWidget(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            "About Us",
                            style: TextStyle(
                              fontSize: isMobile ? 28 : 36,
                              height: 0.9,
                              fontFamily: "MontserratEBold",
                              color: Color(0xFF009688),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            constraints: BoxConstraints(
                              maxWidth: isMobile ? 600 : 800,
                            ),
                            child: Text(
                              "We are a dedicated healthcare platform committed to revolutionizing medical services through technology. "
                              "Our mission is to make quality healthcare accessible to everyone, everywhere. "
                              "With a team of experienced professionals and cutting-edge technology, we provide comprehensive healthcare solutions "
                              "that prioritize patient well-being and convenience.",
                              style: TextStyle(
                                fontSize: isMobile ? 14 : 16,
                                height: 1.5,
                                fontFamily: "Clarendon",
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: isMobile ? 100 : 200),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 100),

                // Contact Section
                Container(
                  key: _contactKey,
                  child: FadeOnScrollWidget(
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/images/thinkingdoctor.png',
                          width: double.infinity,
                          height: isMobile ? 600 : 800,
                          alignment: Alignment(0, -0.3),
                          fit: BoxFit.cover,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: isMobile
                                ? _buildMobileContact()
                                : _buildDesktopContact(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Scroll to top button
          if (_showScrollToTop)
            Positioned(
              bottom: 30,
              right: 30,
              child: FloatingActionButton(
                onPressed: _scrollToTop,
                backgroundColor: Color(0xFF009688),
                child: Icon(Icons.arrow_upward, color: Colors.white),
                mini: true,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDesktopHeader() {
    return Row(
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
            _scrollToSection(_servicesKey);
          },
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
          onPressed: () {
            _scrollToSection(_aboutUsKey);
          },
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
          onPressed: () {
            _scrollToSection(_contactKey);
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
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Accounttype()),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF009688),
              borderRadius: BorderRadius.circular(60),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
        const SizedBox(width: 20),
      ],
    );
  }

  Widget _buildMobileHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "MESMTF",
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFF009688),
                  fontFamily: "BalooPaajiR",
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Accounttype()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF009688),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Text(
                    "REGISTER",
                    style: TextStyle(
                      fontFamily: "Clarendon",
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TextButton(
                onPressed: () {
                  _scrollToSection(_servicesKey);
                },
                child: Text(
                  "Services",
                  style: TextStyle(
                    fontFamily: "Clarendon",
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _scrollToSection(_aboutUsKey);
                },
                child: Text(
                  "About Us",
                  style: TextStyle(
                    fontFamily: "Clarendon",
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _scrollToSection(_contactKey);
                },
                child: Text(
                  "Contact",
                  style: TextStyle(
                    fontFamily: "Clarendon",
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
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
              const SizedBox(height: 20),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Wrap(
                spacing: 40,
                runSpacing: 20,
                children: [
                  AnimatedCounter(count: 500, label: "Expert Doctors"),
                  AnimatedCounter(count: 20, label: "Patients"),
                  AnimatedCounter(count: 100, label: "Health Services"),
                ],
              ),
              const SizedBox(height: 80),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Our Partners",
                  style: TextStyle(fontFamily: "MontserratEBold", fontSize: 16),
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
        ),
      ],
    );
  }

  Widget _buildMobileContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "REVOLUTIONIZING HEALTHCARE, ONE CLICK AWAY",
          style: TextStyle(
            fontSize: 24,
            height: 0.9,
            fontFamily: "MontserratEBold",
            color: const Color(0xFF009688),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Access top-quality medical care without leaving your home. "
          "Our platform connects you with doctors, specialists, and health services "
          "instantly, making healthcare more convenient, reliable, and accessible than ever before.",
          style: TextStyle(
            fontSize: 14,
            fontFamily: "Clarendon",
            color: Colors.black.withOpacity(0.6),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: [
            AnimatedCounter(count: 500, label: "Expert Doctors"),
            AnimatedCounter(count: 20, label: "Patients"),
            AnimatedCounter(count: 100, label: "Health Services"),
          ],
        ),
        const SizedBox(height: 40),
        Center(
          child: Column(
            children: [
              Text(
                "Our Partners",
                style: TextStyle(fontFamily: "MontserratEBold", fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/images/nustlogo.png",
                  width: 100,
                  height: 60,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 100),
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
        const SizedBox(height: 40),
        Wrap(
          spacing: 40,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: List.generate(
            6,
            (index) => _buildServiceItem("24 Hour Support"),
          ),
        ),
        const SizedBox(height: 120),
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
        const SizedBox(height: 40),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) => _buildReviewItem()),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        Text(
          "OUR SERVICES",
          style: TextStyle(
            fontSize: 24,
            height: 0.9,
            fontFamily: "MontserratEBold",
            color: Color(0xFF009688),
          ),
        ),
        Text(
          "Our Services Include many amazing services",
          style: TextStyle(
            fontSize: 12,
            height: 0.9,
            fontFamily: "Clarendon",
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Column(
          children: List.generate(
            3,
            (index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: _buildServiceItem("24 Hour Support"),
            ),
          ),
        ),
        const SizedBox(height: 60),
        Text(
          "CUSTOMER REVIEWS",
          style: TextStyle(
            fontSize: 24,
            height: 0.9,
            fontFamily: "MontserratEBold",
            color: Color(0xFF009688),
          ),
        ),
        Text(
          "View the responses of other people that tried us",
          style: TextStyle(
            fontSize: 12,
            height: 0.9,
            fontFamily: "Clarendon",
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              3,
              (index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: _buildReviewItemMobile(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceItem(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontFamily: "Clarendon",
          color: Color(0xFF009688),
        ),
      ),
    );
  }

  Widget _buildReviewItem() {
    return Container(
      width: 200,
      margin: EdgeInsets.symmetric(horizontal: 10),
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
          const SizedBox(height: 10),
          Text(
            "Was an amazing Experience",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Clarendon",
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItemMobile() {
    return Container(
      width: 150,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Amazing Experience",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Clarendon",
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 300),
        Text(
          "CONTACT US",
          style: TextStyle(
            fontSize: 36,
            height: 0.9,
            fontFamily: "MontserratEBold",
            color: Color(0xFF009688),
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: 280,
          child: EmailTextField(
            controller: TextEditingController(),
            hintText: "Your Email",
          ),
        ),
        const SizedBox(height: 20),
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
                borderSide: BorderSide(color: Color(0xFF009688), width: 2.0),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF009688), width: 2.0),
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
            border: Border.all(color: const Color(0xFF009688), width: 2),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Text(
              "SEND MESSAGE",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Clarendon",
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 200),
        Text(
          "CONTACT US",
          style: TextStyle(
            fontSize: 24,
            height: 0.9,
            fontFamily: "MontserratEBold",
            color: Color(0xFF009688),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 250,
          child: EmailTextField(
            controller: TextEditingController(),
            hintText: "Your Email",
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: 250,
          child: TextField(
            maxLines: 4,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: "Your Message",
              hintStyle: TextStyle(
                color: Color(0xFF009688),
                fontFamily: 'ClarendonBold',
                fontSize: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF009688), width: 2.0),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF009688), width: 2.0),
                borderRadius: BorderRadius.circular(30),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
            ),
            style: TextStyle(
              fontSize: 12,
              height: 0.9,
              fontFamily: 'Clarendon',
              color: Color(0xFF009688),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF009688),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF009688), width: 2),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
            child: Text(
              "SEND MESSAGE",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Clarendon",
                fontSize: 10,
              ),
            ),
          ),
        ),
      ],
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
