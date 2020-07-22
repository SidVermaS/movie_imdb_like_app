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

  Widget getSmallFadedText(String text) {
    return Text(text, style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600));
  }

  Widget getSmallBoldText(String text) {
    return Text(text, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700 , fontSize: 12));
  }  
   Widget getName(String text) {
    return Text(text, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700 , fontSize: 15));
  }  
  Widget getPageTitle(String text)  {
    return Text(text, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600 , fontSize: 18));
  }
  void showToast(String text) {
    Toast.show(text, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }
}