// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Items extends StatelessWidget {
  const Items({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SplashScreen extends StatelessWidget {
  int duration = 0;
  Widget goToPage;
  SplashScreen({required this.goToPage, required this.duration});
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: this.duration), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => this.goToPage));
    });

    return Scaffold(
      body: Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: Image.asset(
          "assets/images/image.png",
          height: 200.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
