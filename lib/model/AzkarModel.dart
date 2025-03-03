// ignore_for_file: file_names, avoid_print

import 'dart:convert';

import 'package:flutter/services.dart';

class AzkarModel {
  final String title;
  final List<ZekrContent> content;

  AzkarModel({
    required this.title,
    required this.content,
  });

  factory AzkarModel.fromJson(Map<String, dynamic> json) {
    var contentList = json['content'] as List;
    List<ZekrContent> content =
        contentList.map((i) => ZekrContent.fromJson(i)).toList();

    return AzkarModel(
      title: json['title'] ?? '', // Default to empty string if null
      content: content,
    );
  }
}

class ZekrContent {
  final String zekr;
  final int repeat;
  final String bless;

  ZekrContent({
    required this.zekr,
    required this.repeat,
    required this.bless,
  });

  factory ZekrContent.fromJson(Map<String, dynamic> json) {
    return ZekrContent(
      zekr: json['zekr'] ?? '', // Default to empty string if null
      repeat: json['repeat'] ?? 0, // Default to 0 if null
      bless: json['bless'] ?? '', // Default to empty string if null
    );
  }
}

Future<AzkarModel> loadAzkarData({required String jsonFile}) async {
  try {
    // 1. تحميل ملف JSON من مجلد assets
    String jsonString = await rootBundle.loadString('assets/$jsonFile.json');

    // 2. تحويل JSON String إلى Map
    final jsonResponse = json.decode(jsonString);

    // 3. تحويل Map إلى كائن من نوع AzkarModel
    return AzkarModel.fromJson(jsonResponse);
  } catch (e) {
    // 4. معالجة الأخطاء (إذا حدث خطأ أثناء التحميل أو التحويل)
    print("حدث خطأ أثناء تحميل البيانات: $e");
    throw Exception("فشل في تحميل البيانات");
  }
}
