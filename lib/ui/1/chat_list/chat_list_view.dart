import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:hoomss/common/widget/hoomss_title.dart';
import 'package:hoomss/data/chat/chat_data_type.dart';
import 'package:hoomss/ui/1/chat/chat_view.dart';
import 'package:hoomss/ui/1/chat_list/chat_list_view_model.dart';
import 'package:hoomss/ui/1/chat_list/widget/difficulty_btn.dart';
import 'package:hoomss/ui/2/word/word_view.dart';

class ChatListView extends StatelessWidget {
  ChatListView({super.key});
  final ChatListViewModel chatListViewModel = Get.put(ChatListViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
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
    return Expanded(child: Obx(() {
      if (chatListViewModel.filterChats.isEmpty) {
        return const Center(
          child: Text('empty'),
        );
      }

      return ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: chatListViewModel.filterChats.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: ListTile(
              onTap: () {
                final filterChat = chatListViewModel.filterChats[index];
                Get.to(() => ChatView(
                      chat: filterChat,
                    ));
              },
              title:
                  Text('✨  ${chatListViewModel.filterChats[index].situation}'),
              titleTextStyle: TextStyle(
                fontSize: 21,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          );
        },
      );
    }));
  }

  Padding difficulty() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: DifficultyType.values.map((difficulty) {
            bool isSelected =
                Get.find<ChatListViewModel>().selectedDifficulty.value ==
                    difficulty;
            return DifficultyBtn(
              difficulty: difficulty,
              isSelected: isSelected,
            );
          }).toList(),
        ),
      ),
    );
  }

  AppBar appbar(context) {
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
      title: hoomssTitle(30, context),
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                Get.to(() => WordView());
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
