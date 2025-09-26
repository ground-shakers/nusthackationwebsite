import 'package:flutter/material.dart';
import 'package:nusthackationwebsite/const/textfield.dart';
import 'package:nusthackationwebsite/pages/chatbot.dart';
import 'package:nusthackationwebsite/pages/dashboard.dart';

class Contactus extends StatefulWidget {
  final String userId;

  const Contactus({super.key, required this.userId});

  @override
  State<Contactus> createState() => _ContactusState();
}

class _ContactusState extends State<Contactus> {
  late final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //Header
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
                      MaterialPageRoute(
                        builder: (context) => ChatbotPage(userId: userId),
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
                        builder: (context) => Contactus(userId: userId),
                      ),
                    );
                  },
                  child: Text(
                    "Contact",
                    style: TextStyle(
                      fontFamily: "Clarendon",
                      fontSize: 16,
                      color: Color(0xFF009688),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {},
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

          SizedBox(height: 60),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
    );
  }
}
