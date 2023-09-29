import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      context.pushReplacementNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Center(
                child: Image.asset(
                  'assets/images/3.gif',
                  fit: BoxFit.cover,
                  height: size.height * 0.4,
                ),
              ),
              const Positioned(
                bottom: 0,
                left: 230,
                child: Text(
                  'Loading',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white60,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
