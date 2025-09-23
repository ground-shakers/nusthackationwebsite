import 'package:flutter/material.dart';

class AnimatedCounter extends StatefulWidget {
  final int count;
  final String label;

  const AnimatedCounter({super.key, required this.count, required this.label});

  @override
  State<AnimatedCounter> createState() => AnimatedCounterState();
}

class AnimatedCounterState extends State<AnimatedCounter> {
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
