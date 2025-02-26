import 'package:flutter/material.dart';

import '../../../core/cache_helper.dart';
import '../../../core/color_manager.dart';
import '../../../core/helper_methods.dart';
import '../../constant/constants.dart';
import '../../constant/logo_name.dart';
import '../../surah_design/surah.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'الذهاب إلى الشارة المرجعية',
        backgroundColor: ColorManager.goldenColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () async {
          fabIsClicked = true;
          if (await readBookmark() == true) {
            navigateTo(
                page: SurahPage(
              arabic: quran[0],
              surah: bookmarkedSura - 1,
              surahName: arabicName[bookmarkedSura - 1]['name'],
              ayah: bookmarkedAyah,
            ));
          }
        },
        child: Icon(
          Icons.bookmark,
          color: Theme.of(context).scaffoldBackgroundColor,
          size: 30,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: readJson(),
          builder: (
            BuildContext context,
            AsyncSnapshot snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: ColorManager.orangeColor,
              ));
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('خطأ');
              } else if (snapshot.hasData) {
                return indexCreator(snapshot.data, context);
              } else {
                return const Text('لا توجد بيانات');
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          },
        ),
      ),
    );
  }

  SizedBox indexCreator(quran, context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const LogoName(),
            for (int i = 0; i < 114; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).listTileTheme.tileColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: ColorManager.yellowColor,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 30,
                            decoration: BoxDecoration(
                              color: ColorManager.yellowColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Text(
                                arabicName[i]['surah'],
                                style: TextStyle(
                                  color: ColorManager.black,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            arabicName[i]['name'],
                            style: TextStyle(
                              fontSize: 30,
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color,
                              fontFamily: 'quran',
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      ),
                      onPressed: () {
                        fabIsClicked = false;
                        navigateTo(
                          page: SurahPage(
                            arabic: quran[0],
                            surah: i,
                            surahName: arabicName[i]['name'],
                            ayah: 0,
                          ),
                        );
                      }),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
