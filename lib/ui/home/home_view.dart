import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoomss/common/widget/hoomss_title.dart';
import 'package:hoomss/data/database_service.dart';
import 'package:hoomss/data/word/word_data_type.dart';
import 'package:hoomss/ui/1/chat_list/chat_list_view.dart';
import 'package:hoomss/ui/2/word/word_view.dart';
import 'package:hoomss/ui/2/word/word_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final DatabaseService databaseService = DatabaseService();
  final WordViewModel wordViewModel = Get.put(WordViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            hoomssTitle(48, context),
            const SizedBox(
              height: 55,
            ),

            Text(
              '흐흐.. 훔치고 싶은게 뭐야?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(
              height: 55,
            ),

            //conversation view
            conversation(context),
            const SizedBox(
              height: 40,
            ),
            word(context)
          ],
        ),
      ),
    );
  }

  GestureDetector word(context) {
    return GestureDetector(
      onTap: () {
        wordViewModel.loadData();
        wordViewModel.percent(ModeType.basic.toKo);
        wordViewModel.percent(ModeType.koreaTest.toKo);
        wordViewModel.percent(ModeType.toeic.toKo);

        Get.to(() => const WordView());
      },
      child: Container(
        width: 207,
        height: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Center(
          child: Text(
            '단어',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector conversation(context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const ChatListView());
      },
      child: Container(
        width: 207,
        height: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Center(
          child: Text(
            '회화',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
