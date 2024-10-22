import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hoomss/admob/ad_helper.dart';
import 'package:hoomss/common/widget/hoomss_title.dart';
import 'package:hoomss/data/chat/chat_data_type.dart';
import 'package:hoomss/ui/1/chat/chat_view.dart';
import 'package:hoomss/ui/1/chat_list/chat_list_view_model.dart';
import 'package:hoomss/ui/1/chat_list/widget/difficulty_btn.dart';
import 'package:hoomss/ui/2/word/word_view.dart';
import 'package:hoomss/ui/2/word/word_view_model.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({super.key});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  final ChatListViewModel chatListViewModel = Get.put(ChatListViewModel());
  BannerAd? _bannerAd;
  bool _isBannerReady = false;

  @override
  void initState() {
    adHelper().configureAdSettings(
      (ad) => {
        if (_bannerAd == null)
          {
            setState(() {
              _bannerAd = ad;
              _isBannerReady = true;
            })
          }
      },
      BannerType.small,
    );
    super.initState();
  }

  @override
  void dispose() {
    adHelper().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                children: [
                  //난이도
                  difficulty(),

                  //대화방 목록
                  list(),
                ],
              ),
            ),
          ),

          //배너 광고
          if (_isBannerReady)
            SafeArea(
              child: SizedBox(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
            )
        ],
      ),
    );
  }

  Expanded list() {
    return Expanded(
      child: Obx(
        () {
          if (chatListViewModel.filterChats.isEmpty) {
            return const Center(
              child: Text('empty'),
            );
          }
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              thickness: 0.5,
            ),
            itemCount: chatListViewModel.filterChats.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  final filterChat = chatListViewModel.filterChats[index];
                  Get.to(() => ChatView(
                        chat: filterChat,
                      ));
                },
                leading: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  child: Text(
                    'HS',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                title: Text(chatListViewModel.filterChats[index].situation),
                titleTextStyle: TextStyle(
                  fontSize: 21,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              );
            },
          );
        },
      ),
    );
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
                Get.find<WordViewModel>().loadData();
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
