import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:nusthackationwebsite/pages/contactus.dart';
import 'package:nusthackationwebsite/pages/dashboard.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "text": _controller.text.trim()});
      _messages.add({"role": "bot", "text": "This is a bot reply."});
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
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
                              builder: (context) => const ChatbotPage(),
                            ),
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Contactus(),
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
                    ],
                  ),
                ),
              ],
            ),

            // Chat Area
            Expanded(
              child: _messages.isEmpty
                  ? Center(
                      child: Text(
                        "How Can We Help You Today?",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "MontserratEBold",
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF009688),
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(20.w),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final msg = _messages[index];
                        final isUser = msg["role"] == "user";
                        return Align(
                          alignment: isUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 5.h),
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: isUser
                                  ? const Color(0xFF009688)
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              msg["text"]!,
                              style: TextStyle(
                                color: isUser ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),

            // Input Box
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: Color(0xFF009688), width: 2),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: TextField(
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "ClarendonBold",
                          ),
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: "Type a message...",
                            border: InputBorder.none,
                          ),
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(
                      LucideIcons.send,
                      color: Color(0xFF009688),
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
