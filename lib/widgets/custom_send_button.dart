import 'package:flutter/material.dart';

import '../constants.dart';

class CustomSendButton extends StatelessWidget {
  CustomSendButton({this.onTap}) ;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        child: Icon(Icons.send,color: primaryColor,),
      ),
    );
  }
}
