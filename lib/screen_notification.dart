import 'package:firebase_notification/screen_snake_bar.dart';
import 'package:flutter/material.dart';


class Screen_notification extends StatefulWidget {
  final String notifiaction_title;
  Screen_notification({required this.notifiaction_title});


  @override
  State<Screen_notification> createState() => _Screen_notificationState();
}

class _Screen_notificationState extends State<Screen_notification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.notifiaction_title)
      ),
      floatingActionButton: FloatingActionButton(onPressed:(){
        WidgetsReusing.getSnakeBar(context,"message");
      },
      child: Icon(Icons.message),
      ),
      body: Container(
        color: Colors.lightBlue,
      ),
    );
  }
}
