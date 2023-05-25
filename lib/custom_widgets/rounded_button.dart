import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.cornerRadius,
      this.buttonColor,
      required this.height,
      required this.width})
      : super(key: key);

  final String title;
  final VoidCallback onTap;
  final double cornerRadius;
  final buttonColor;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor,
            borderRadius: BorderRadius.circular(cornerRadius),
            border: Border.all(width: 1,color: Colors.white)),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
