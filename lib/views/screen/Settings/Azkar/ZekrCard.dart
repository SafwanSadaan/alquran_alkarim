// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../../core/cache_helper.dart';
import '../../../../model/AzkarModel.dart';

class ZekrCard extends StatefulWidget {
  final ZekrContent zekr;
  final int index;
  const ZekrCard({super.key, required this.zekr, required this.index});

  @override
  State<ZekrCard> createState() => _ZekrCardState();
}

class _ZekrCardState extends State<ZekrCard> {
  int repeatCount = 0;

  void incrementRepeat() {
    setState(() {
      if (repeatCount < widget.zekr.repeat) {
        repeatCount++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: widget.index % 2 != 0
          ? Theme.of(context).textTheme.displayLarge?.color
          : Theme.of(context).textTheme.displayMedium?.color,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // نص الذكر
            Text(
              widget.zekr.zekr,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: arabicFontSize * 0.9,
                fontFamily: arabicFont,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            // نص الفائدة
            Text(
              widget.zekr.bless,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: arabicFontSize * 0.7,
                fontFamily: arabicFont,
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.color!
                    .withOpacity(0.6),
              ),
            ),
            SizedBox(height: 10),
            // زر التكرار
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "التكرار: ${widget.zekr.repeat}",
                  style: TextStyle(fontSize: 14, color: Colors.teal),
                ),
                ElevatedButton(
                  onPressed: incrementRepeat,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "كرر الذكر ($repeatCount)",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
