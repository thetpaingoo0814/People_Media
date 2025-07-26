// This code is create by M23W7502_ThetPaingOo
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class Kpo {
  static Widget showLoadingIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
          ),
        ],
      ),
    );
  }

  static successToast(BuildContext context, String msg) =>
      getToast(context, msg, Colors.greenAccent);
  static errorToast(BuildContext context, String msg) =>
      getToast(context, msg, Colors.pinkAccent);

  static getToast(BuildContext context, String msg, color) {
    return showToast(
      msg,
      context: context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.center,
      animDuration: Duration(seconds: 1),
      duration: Duration(seconds: 4),
      curve: Curves.elasticOut,
      backgroundColor: color,
      reverseCurve: Curves.linear,
    );
  }
}
