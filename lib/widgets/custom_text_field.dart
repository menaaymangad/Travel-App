// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({super.key, this.label, this.hint, this.function,this.obsecure=false,this.suffixIcon});
  String? label;
  String? hint;
  bool? obsecure;
  Icon? suffixIcon;
  Function(String)? function;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecure!,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field is required';
        }
        return null;
       
      
      } ,
      onChanged: function,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        label: Text(
          label ?? '',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2,
            style: BorderStyle.solid,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2,
            style: BorderStyle.solid,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2,
            style: BorderStyle.solid,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
