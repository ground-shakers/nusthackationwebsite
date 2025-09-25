import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = []; // store chat messages

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "text": _controller.text.trim()});
      // bot response
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

            // Chat Area
            Expanded(
              child: _messages.isEmpty
                  ? Center(
                      child: Text(
                        "How Can We Help You Today",
                        style: TextStyle(
                          fontSize: 20.sp,
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
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: TextField(
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
                    icon: const Icon(Icons.send, color: Color(0xFF009688)),
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
