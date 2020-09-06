import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
            fontSize: 30
        ),
        children: <TextSpan>[
          TextSpan(text: 'Diabetic', style: TextStyle(fontWeight: FontWeight.w600
              , color: Colors.black54)),
          TextSpan(text: ' Helper ', style: TextStyle(fontWeight: FontWeight.w600
              , color: Colors.green)),
        ],
      ),
    );
  }
}
