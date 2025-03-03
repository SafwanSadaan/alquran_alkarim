// ignore_for_file: file_names, unnecessary_null_comparison

import 'package:flutter/material.dart';

import '../../../../core/cache_helper.dart';
import '../../../../core/color_manager.dart';
import '../../../../model/AzkarModel.dart';
import 'ZekrCard.dart';

class AzkarScreen extends StatelessWidget {
  final AzkarModel azkarData;

  const AzkarScreen({super.key, required this.azkarData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          azkarData.title,
          style: TextStyle(
            fontFamily: arabicFont,
            fontSize: 24,
            color: ColorManager.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: (azkarData == null)
          ? Center(
              child: CircularProgressIndicator(
              color: ColorManager.orangeColor,
            ))
          : ListView.builder(
              itemCount: azkarData.content.length,
              itemBuilder: (context, index) {
                var zekr = azkarData.content[index];
                return ZekrCard(zekr: zekr, index: index);
              },
            ),
    );
  }
}
