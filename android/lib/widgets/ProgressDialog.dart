import 'package:flutter/material.dart';
class ProgressDialog extends StatelessWidget {
  final String status;

  ProgressDialog({this.status});

  @override
  Widget build(BuildContext dialogContext) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4)
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              SizedBox(width: 5,),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF21ba45)),),
              SizedBox(width: 25.0,),
              Text(status, style: TextStyle(fontSize: 15),),
            ],
          ),
        ),
      ),
    );
  }
}