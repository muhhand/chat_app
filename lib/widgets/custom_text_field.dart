import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
CustomTextField({this.onChanged,this.hintText,this.obsecureText=false});

  String? hintText;

  Function(String)? onChanged;
  bool? obsecureText;

  @override
  Widget build(BuildContext context) {
  return TextFormField(
    obscureText: obsecureText!,
    validator: (data){
      if (data!.isEmpty){
        return "field is required";
      }
    },
    style: TextStyle(color: Colors.white),
    onChanged: onChanged,
  decoration: InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.white
  ),
  enabledBorder: OutlineInputBorder(
  borderSide: BorderSide(
  color: Colors.white,
  ),
  ),
  border: OutlineInputBorder(
  borderSide: BorderSide(
  color: Colors.white,
  ),),
  ),
  );
  }
}
