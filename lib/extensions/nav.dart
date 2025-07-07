import 'package:flutter/material.dart';

extension Nav on BuildContext{
//Switches to a new screen while keeping the current screen in the background.
  void moveTo({required BuildContext context,required Widget screen}){
    Navigator.push(this, MaterialPageRoute(builder: (context) => screen));
  }

//Moves to a new screen and replaces the current one.
  void moveToWithReplacement({required BuildContext context, required Widget screen}) {
    Navigator.pushReplacement(this, MaterialPageRoute(builder: (context) => screen));
  }

  void pop() {
    Navigator.pop(this);
  }
}