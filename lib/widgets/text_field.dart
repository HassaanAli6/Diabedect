import 'package:flutter/material.dart';

class buildTextField extends StatelessWidget {
  const buildTextField({
    super.key, required this.controller, required this.hintText, required this.keyboardType, this.isPassword=false
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool isPassword;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 3.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}

