import 'package:flutter/material.dart';

extension Nav on BuildContext{

  void moveTo({required BuildContext context,required Widget screen}){
    Navigator.push(this, MaterialPageRoute(builder: (context) => screen));
  }


  void moveToWithReplacement({required BuildContext context, required Widget screen}) {
    Navigator.pushReplacement(this, MaterialPageRoute(builder: (context) => screen));
  }

  void pop() {
    Navigator.pop(this);
  }
}