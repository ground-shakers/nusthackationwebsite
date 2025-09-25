// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

// Password Text Field with Show/Hide Feature
class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText; // Optional hint text

  const PasswordTextField({super.key, required this.controller, this.hintText});

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: TextField(
        controller: widget.controller,
        obscureText: _obscured,
        style: TextStyle(
          fontFamily: 'ClarendonBold',
          fontSize: 14,
          color: Color(0xFF009688),
          height: 0.9,
        ),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: widget.hintText ?? 'Enter Password',
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
          contentPadding: EdgeInsets.only(left: 54, top: 24, bottom: 24),
          suffixIcon: IconButton(
            iconSize: 24,
            icon: Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(
                _obscured ? LucideIcons.eye : LucideIcons.eyeOff,
                color: Color(0xFF009688),
              ),
            ),
            onPressed: () {
              setState(() {
                _obscured = !_obscured;
              });
            },
          ),
        ),
      ),
    );
  }
}

// Email Text Field
class EmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;

  const EmailTextField({super.key, required this.controller, this.hintText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: hintText ?? 'Your Email',
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
          contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        ),
        style: TextStyle(
          fontSize: 14,
          height: 0.9,
          fontFamily: 'Clarendon',
          color: Color(0xFF009688),
        ),
      ),
    );
  }
}
