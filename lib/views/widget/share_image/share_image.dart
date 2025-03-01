// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/cache_helper.dart';
import '../../../core/color_manager.dart';

// ignore: must_be_immutable
class ShareImage extends StatelessWidget {
  final surahNameEn;
  final ayah;
  final surahNameAr;
  int surahNumber;

  ShareImage({
    super.key,
    required this.surahNameEn,
    required this.ayah,
    required this.surahNameAr,
    required this.surahNumber,
  });
  final screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            BackButton(color: Theme.of(context).textTheme.bodyLarge?.color),
        elevation: 0.0,
        title: Text(
          "مشاركة",
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ),
      bottomSheet: InkWell(
        onTap: () async {
          final image = await screenshotController.capture();
          saveAndShare(image!, context);
        },
        child: Container(
          height: 40,
          width: double.infinity,
          color: ColorManager.orangeColor,
          child: Center(
            child: Text(
              "مشاركة الصورة",
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Screenshot(
            controller: screenshotController,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 100,
                        width: 40,
                        child: Image.asset(
                          'assets/design.webp',
                          fit: BoxFit.fill,
                          color: ColorManager.orangeColor,
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Text(
                        ayah,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: arabicFont,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "سُورَة $surahNameAr",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: arabicFont,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          surahNameEn,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 1.5,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: ColorManager.yellowColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                surahNumber.toString(),
                                style: TextStyle(
                                  color: ColorManager.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 100,
                      width: 40,
                      child: Transform.rotate(
                        angle: 3.1,
                        child: Image.asset(
                          'assets/design.webp',
                          fit: BoxFit.fill,
                          color: ColorManager.orangeColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "القران الكريم",
                      style: TextStyle(
                          color: ColorManager.orangeColor, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      "تطبيق الموبايل",
                      style: TextStyle(
                          color: ColorManager.orangeColor, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Future saveAndShare(Uint8List bytes, BuildContext context) async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      // تأكد من أن التطبيق ليس ويب وأنه يعمل على Android
      final directory = await getApplicationDocumentsDirectory();
      final image = File('${directory.path}/flutter.png');
      image.writeAsBytes(bytes);

      final xFile = XFile(image.path);
      await Share.shareXFiles([xFile], text: "مشاركة من تطبيق القرآن الكريم");
    } else if (kIsWeb) {
      // إذا كان التطبيق يعمل على الويب، يمكنك عرض رسالة
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("لا يمكن مشاركة الصورة في تطبيقات الويب."),
        ),
      );
    }
  }
}
