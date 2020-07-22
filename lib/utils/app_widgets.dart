import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class AppWidgets  {
  BuildContext context;

  Widget getRaisedButton(VoidCallback voidCallback, String text)  {
    return ButtonTheme(
      height: 50,
      child: RaisedButton(
      color: Colors.blue,
      child: Text(text, style: TextStyle(color: Colors.white),),
      onPressed: voidCallback,
      disabledColor: Colors.blue[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5)
      ),
    ));
  }
  Widget getCircularProgressIndicator()  {
    return Center(child: CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.grey),));
  }

  void showToast(String text) {
    Toast.show(text, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }
}