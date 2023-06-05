import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetsReusing {
  static getSnakeBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          elevation: 0,
          duration: Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
          content: Text(message, style: TextStyle(fontSize: 18)),
          backgroundColor: Colors.grey[800]),
    );
  }

  static PageRouteBuilder OpenNewActivity(context, screen) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, _) {
        return FadeTransition(opacity: animation, child: screen);
      },
    );
  }
}