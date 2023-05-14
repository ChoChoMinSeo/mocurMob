import 'package:flutter/material.dart';

Widget background(Widget wid){
  return SafeArea(
      child: DefaultTextStyle(
        style: TextStyle(
          fontFamily: 'Pretend',
          color: Colors.black
        ),
        child: wid,
        )
      );
}