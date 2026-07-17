import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastHelper {

  static void show (String msg ){
  Fluttertoast.showToast(msg: msg,
  textColor: Colors.white,
  backgroundColor:Color(0xFF808000),
  toastLength: Toast.LENGTH_SHORT

  );
}
}