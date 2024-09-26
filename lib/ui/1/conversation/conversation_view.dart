import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:hoomss/common/widget/hoomss_title.dart';
import 'package:hoomss/ui/1/chat/chat_view.dart';
import 'package:hoomss/ui/1/conversation/widget/difficulty_btn.dart';
import 'package:hoomss/ui/2/word/word_view.dart';

class ConversationView extends StatelessWidget {
  const ConversationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          children: [
            //난이도
            difficulty(),

            //대화방 목록
            list(),

            //랜덤버튼

            //배너광고?
          ],
        ),
      ),
    );
  }

  Expanded list() {
    return Expanded(
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Get.to(() => const ChatView());
                    },
                    leading: const CircleAvatar(),
                    title: const Text('Name'),
                    subtitle: const Text('description'),
                    trailing: const Icon(
                      FeatherIcons.check,
                      color: Colors.green,
                    ),
                  ),
                );
              },
            ),
          );
  }

  Padding difficulty() {
    return const Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DifficultyBtn(difficulty: '쉬움'),
                DifficultyBtn(difficulty: '보통'),
                DifficultyBtn(difficulty: '어려움'),
              ],
            ),
          );
  }

  AppBar appbar() {
    return AppBar(
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              FeatherIcons.arrowLeft,
              size: 32,
            )),
      ),
      title: hoomssTitle(30),
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                Get.to(() => const WordView());
              },
              icon: const Icon(
                FeatherIcons.book,
                size: 30,
              ),
            )),
      ],
    );
  }
}
