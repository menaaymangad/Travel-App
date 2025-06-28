import 'package:flutter/material.dart';

import '../features/auth/presentation/pages/login_page.dart';

class responsivebutton extends StatelessWidget {
  bool isResponsive;
  double? width;
  responsivebutton({Key? key, this.width, this.isResponsive = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 100,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xff4a76a8),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'skip',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  textBaseline: TextBaseline.alphabetic),
            ),
            Icon(Icons.arrow_forward, size: 25, color: Colors.white),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
    );
  }
}
