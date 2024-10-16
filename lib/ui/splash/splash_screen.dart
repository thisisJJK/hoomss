import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoomss/common/widget/hoomss_title.dart';
import 'package:hoomss/ui/home/home_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 1500), () {
      Get.to(() => const HomeView());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            hoomssTitle(48),
            const SizedBox(
              height: 45,
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
