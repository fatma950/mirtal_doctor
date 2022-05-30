// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:mirtal_doctor/Constants/colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final String hint;
  final IconData icon;
  bool isPassword;
  CustomTextField({
    Key? key,
    required this.textEditingController,
    required this.keyboardType,
    required this.hint,
    required this.icon,
    required this.isPassword,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        controller: widget.textEditingController,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword ? true : false,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon, color: appColor, size: 24),
          suffixIcon: widget.isPassword
              ? InkWell(
                  onTap: () {
                    setState(() {
                      widget.isPassword = !widget.isPassword;
                    });
                  },
                  child: Icon(
                      widget.isPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: appColor,
                      size: 24))
              : const SizedBox(
                  width: 10,
                  height: 10,
                ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
          labelText: widget.hint,
        ),
      ),
    );
  }
}
