// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

import '../../../core/cache_helper.dart';
import '../../../core/constant/constants.dart';
import '../../../core/helper_methods.dart';
import '../../../model/AyatModel.dart';
import '../surah_design/surah.dart';

class CustomSearchResults extends StatefulWidget {
  const CustomSearchResults({required this.searchResults, super.key});
  final List<AyatModel> searchResults; // تغيير النوع إلى List<AyatModel>

  @override
  State<CustomSearchResults> createState() => _CustomSearchResultsState();
}

class _CustomSearchResultsState extends State<CustomSearchResults>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: widget.searchResults.length,
          itemBuilder: (context, index) {
            var result = widget.searchResults[index];
            return InkWell(
              onTap: () {
                navigateTo(
                    page: SurahPage(
                  arabic: quran[0],
                  surah: result.suraNo - 1,
                  surahName: arabicName[result.suraNo - 1]['name'],
                  ayah: result.ayaNo,
                ));
              },
              child: Card(
                elevation: 0.2,
                color: index % 2 != 0
                    ? Theme.of(context).textTheme.displayLarge?.color
                    : Theme.of(context).textTheme.displayMedium?.color,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${result.ayaText} [${result.suraNameAr}]',
                              textDirection: TextDirection.rtl,
                              // maxLines: 5, // تحديد عدد الأسطر
                              // overflow: TextOverflow
                              //     .ellipsis, // إضافة "..." إذا تجاوز النص المساحة
                              style: TextStyle(
                                fontSize:
                                    arabicFontSize * 0.9, // تقليل حجم الخط
                                fontFamily: arabicFont,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color,
                              ),
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
