import 'package:flutter/material.dart';

void showProgressDialog(BuildContext context, String label) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(color: Colors.black,),
            SizedBox(height: 10),
            Text(label + "..."),
          ],
        ),
      );
    },
  );
}