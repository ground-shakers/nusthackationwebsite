import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      body: Column(
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
            ],
          ),
        ],
      ),
    );
  }
}
