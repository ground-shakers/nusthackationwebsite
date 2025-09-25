import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// Password Text Field
class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText; // Optional hint text
  final bool doesMatch; // New parameter to control border color

  const PasswordTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.doesMatch = true, // Default to true (matching)
  });

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscured = true;

  // Helper method to get border color based on match status
  Color get _borderColor {
    return widget.doesMatch ? Color(0xFF009688) : Colors.red;
  }

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
            borderSide: BorderSide(color: _borderColor, width: 2.0),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _borderColor, width: 2.0),
            borderRadius: BorderRadius.circular(30),
          ),
          contentPadding: EdgeInsets.only(left: 54, top: 24, bottom: 24),
          suffixIcon: IconButton(
            iconSize: 24,
            icon: Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(
                _obscured ? LucideIcons.eye : LucideIcons.eyeOff,
                color: _borderColor, // Icon color also changes for consistency
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

//Small Username field
class UserNameField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const UserNameField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            fontFamily: 'ClarendonBold',
            color: Color(0xFF009688),
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

//Date of Birth Field
class DateOfBirthField extends StatelessWidget {
  final TextEditingController controller;

  const DateOfBirthField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final dateMaskFormatter = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );

    return SizedBox(
      width: 280,
      child: TextFormField(
        controller: controller,
        inputFormatters: [dateMaskFormatter],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          height: 0.9,
          fontFamily: 'Clarendon',
          color: Color(0xFF009688),
        ),
        decoration: InputDecoration(
          hintText: 'DD/MM/YYYY',
          hintStyle: TextStyle(
            fontSize: 14,
            color: Color(0xFF009688),
            fontFamily: 'ClarendonBold',
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF009688), width: 2.0),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF009688), width: 2.0),
            borderRadius: BorderRadius.circular(30),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 24, horizontal: 18),
        ),
      ),
    );
  }
}

//Custom Drop Down
class CustomDropdown extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final List<String> options;

  const CustomDropdown({
    super.key,
    required this.controller,
    required this.hintText,
    required this.options,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.controller.text.isNotEmpty
        ? widget.controller.text
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 280,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Color(0xFF009688), width: 2.0),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedOption,
                dropdownColor: Colors.white,
                hint: Center(
                  child: Text(
                    widget.hintText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF009688),
                      fontFamily: 'ClarendonBold',
                      fontSize: 14,
                    ),
                  ),
                ),
                isExpanded: true,
                icon: Icon(LucideIcons.arrowDown, color: Color(0xFF009688)),
                items: widget.options.map((option) {
                  return DropdownMenuItem(
                    value: option,
                    child: Center(
                      child: Text(
                        option,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Clarendon',
                          color: Color(0xFF009688),
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                    widget.controller.text = selectedOption ?? '';
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
