import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoomss/common/widget/hoomss_title.dart';
import 'package:hoomss/ui/splash/splash_view_model.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashViewModel splashViewModel = Get.put(SplashViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            hoomssTitle(48, context),
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
