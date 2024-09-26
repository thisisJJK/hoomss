import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoomss/common/widget/hoomss_title.dart';
import 'package:hoomss/ui/1/conversation/conversation_view.dart';
import 'package:hoomss/ui/2/word/word_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            hoomssTitle(48),
            const SizedBox(
              height: 55,
            ),

            const Text(
              '흐흐.. 훔치고 싶은게 뭐야?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 55,
            ),

            //conversation view
            conversation(),
            const SizedBox(
              height: 40,
            ),
            word()
          ],
        ),
      ),
    );
  }

  GestureDetector word() {
    return GestureDetector(
      onTap: () {
        Get.to(() => const WordView());
      },
      child: Container(
        width: 207,
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: const Center(
          child: Text(
            '단어',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector conversation() {
    return GestureDetector(
      onTap: () {
        Get.to(() => const ConversationView());
      },
      child: Container(
        width: 207,
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: const Center(
          child: Text(
            '회화',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
