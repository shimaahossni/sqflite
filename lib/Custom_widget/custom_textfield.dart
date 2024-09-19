import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final String hint;
  final TextCapitalization textCapitalization;
  final TextInputType inputType;


  const CustomTextField({
    super.key,
    required this.controller,
    required this.name,
    required this.hint,
    this.textCapitalization=TextCapitalization.none,
    required this.inputType
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: true,
      controller: controller,
      textCapitalization: textCapitalization,
      keyboardType: inputType,
      maxLines: 1,
      maxLength: 32,
      textAlign: TextAlign.start,
      style: TextStyle(
          color: Colors.black,
          fontSize: 18
      ),
      decoration: InputDecoration(
        isDense: true,
        labelText: name,
        counterText: "",
        labelStyle: TextStyle(color: Colors.grey,),

        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
