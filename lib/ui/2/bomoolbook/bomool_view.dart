import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:hoomss/data/model/word_model.dart';
import 'package:hoomss/ui/2/bomoolbook/bomool_view_model.dart';
import 'package:hoomss/ui/2/bomoolbook/widget/edit_dialog.dart';
import 'package:hoomss/ui/2/bomoolbook/widget/word_card.dart';

class BomoolView extends StatelessWidget {
  BomoolView({super.key});

  final BomoolViewModel _bomoolViewModel = Get.put(BomoolViewModel());

  final TextEditingController engController = TextEditingController();
  final TextEditingController korController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: FutureBuilder(
          future: _bomoolViewModel.wordList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _bomoolViewModel.currentCount = snapshot.data!.length;
              if (_bomoolViewModel.currentCount == 0) {
                return const Center(
                  child: Text('NO DATA'),
                );
              } else {
                return GridView.builder(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Future<WordModel> word = Get.find<BomoolViewModel>()
                            .databaseService
                            .readWord(snapshot.data![index].id);
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => EditDialog(
                                id: snapshot.data![index].id,
                                engController: engController,
                                korController: korController,
                                word: word));
                      },
                      child: WordCard(
                          word: snapshot.data![index].eng,
                          meaning: snapshot.data![index].kor),
                    );
                  },
                );
              }
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('error'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            }
          }),
    );
  }

  AppBar appbar() {
    return AppBar(
      centerTitle: true,
      title: const Row(
        children: [
          Icon(FeatherIcons.book),
          SizedBox(width: 3),
          Text(
            '보물 단어장',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
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
    );
  }
}
