// ignore_for_file: library_private_types_in_public_api, file_names, invalid_use_of_protected_member, use_build_context_synchronously

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../../core/color_manager.dart';
import '../../../provider/Arabic_Tools.dart';
import '../../../model/AyatModel.dart';
import '../../widget/search/custom_card_search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<AyatModel> ayatOfSearch2 = []; // قائمة لتخزين نتائج البحث
  var quranData = []; // Store loaded JSON data
  var isLoading = true; // Added loading indicator false;

  bool _isListening = false;
  late stt.SpeechToText _speech;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    loadQuranData(); // Load JSON data on init
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator()) // Show loading indicator
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _searchController,
                        onChanged: search,
                        decoration: InputDecoration(
                          hoverColor: ColorManager.green.withOpacity(0.2),
                          fillColor: ColorManager.grey.withOpacity(0.3),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorManager.blueColor),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.green),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          labelText: 'بحث',
                          labelStyle: TextStyle(color: ColorManager.blueColor),
                          prefixIcon:
                              Icon(Icons.search, color: ColorManager.blueColor),
                          suffixIcon: IconButton(
                            icon: Icon(
                                _isListening ? Icons.mic : Icons.mic_none,
                                color: _isListening
                                    ? ColorManager.green
                                    : ColorManager.blueColor),
                            onPressed:
                                _isListening ? _stopListening : _startListening,
                          ),
                        ),
                      ),
                    ),
                    CustomSearchResults(searchResults: ayatOfSearch2),
                  ],
                ),
        ),
      ),
    );
  }

  void _startListening() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      await Permission.microphone.request();
      if (!await Permission.microphone.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  "يرجى منح الإذن للوصول إلى الميكروفون لتتمكن البحث الصوتي")),
        );
        return;
      }
    }

    bool available = await _speech.initialize();
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(onResult: (val) {
        setState(() {
          _searchController.text = '';
          _searchController.text = val.recognizedWords;
          search(val.recognizedWords);
        });
      });
    }
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _speech.stop();
  }

// دالة لتطبيع الحروف العربية
  String normalizeArabic(String text) {
    Map<String, String> arabicMap = {
      'أ': 'ا',
      'إ': 'ا',
      'آ': 'ا',
      'ة': 'ه',
      'ى': 'ي',
      'ئ': 'ي',
      'ؤ': 'و',
      ')': '',
      '(': '',
      '<': '',
      '>': '',
      '}': '',
      '{': '',
      ']': '',
      '[': '',
      '،': '',
      '.': '',
      ':': '',
      '؛': '',
      ',': '',
      ';': '',
      '\\': '',
      '/': '',
      '|': '',
      '+': '',
      '-': '',
      '_': '',
      '=': '',
      '*': '',
      '&': '',
      '^': '',
      '%': '',
      '\$': '',
      '#': '',
      '@': '',
      '!': '',
      '~': '',
      '`': '',
      '?': '',
      '؟': '',
      '\'': '',
      '"': '',
    };

// إزالة المسافات من بداية ونهاية النص
    text = text.trim();

    arabicMap.forEach((key, value) {
      text = text.replaceAll(key, value);
    });
    return text;
  }

// التعامل مع الأخطاء الإملائية
  int levenshteinDistance(String s, String t) {
    // تحويل الأحرف إلى حروف صغيرة لتجنب اعتبار الأحرف الكبيرة كاختلاف
    s = s.toLowerCase();
    t = t.toLowerCase();

    if (s == t) return 0;
    if (s.isEmpty) return t.length;
    if (t.isEmpty) return s.length;

    // إنشاء المصفوفة لحفظ المسافات
    List<List<int>> matrix =
        List.generate(s.length + 1, (i) => List<int>.filled(t.length + 1, 0));

    for (int i = 0; i <= s.length; i++) {
      matrix[i][0] = i;
    }
    for (int j = 0; j <= t.length; j++) {
      matrix[0][j] = j;
    }

    // حساب المسافة مع دعم التبديلات
    for (int i = 1; i <= s.length; i++) {
      for (int j = 1; j <= t.length; j++) {
        int cost = s[i - 1] == t[j - 1] ? 0 : 1;

        // حساب العمليات الثلاثة (إدخال، حذف، استبدال)
        matrix[i][j] = min(
          matrix[i - 1][j] + 1, // حذف
          min(
              matrix[i][j - 1] + 1, // إدخال
              matrix[i - 1][j - 1] + cost // استبدال
              ),
        );

        // دعم تبديلات الأحرف المجاورة
        if (i > 1 && j > 1 && s[i - 1] == t[j - 2] && s[i - 2] == t[j - 1]) {
          matrix[i][j] = min(matrix[i][j], matrix[i - 2][j - 2] + 1); // تبديل
        }
      }
    }

    return matrix[s.length][t.length];
  }

  Future<void> loadQuranData() async {
    // تحميل ملف JSON
    final String response =
        await rootBundle.loadString("assets/hafs_smart_v8.json");
    final data = await json.decode(response);
    final List<dynamic> ayat = data["quran"];

    // تحويل البيانات إلى قائمة من الكائنات AyatModel
    quranData = ayat.map((aya) => AyatModel.fromJson(aya)).toList();
    isLoading = false;
    setState(() {});
  }

  Future<void> search(String query) async {
    // تطبيع الاستعلام وإزالة التشكيل
    String normalizedQuery =
        normalizeArabic(ArabicTools().removeTashkeel(query.toLowerCase()));

    List<AyatModel> exactMatches = []; // المطابقات التامة
    List<AyatModel> closeMatches = []; // المطابقات القريبة

    // البحث في كل آية
    for (var aya in quranData) {
      String ayaText =
          ArabicTools().removeTashkeel(aya.ayaTextEmlaey.toLowerCase());
      String normalizedAyaText = normalizeArabic(ayaText);

      // التحقق من المطابقة التامة
      if (normalizedAyaText.contains(normalizedQuery)) {
        exactMatches.add(aya);
      } else {
        // حساب المسافة بين الاستعلام والنص باستخدام Levenshtein Distance
        int distance = levenshteinDistance(normalizedQuery, normalizedAyaText);

        // إذا كانت المسافة صغيرة (مثلاً أقل من أو تساوي 2)، نعتبرها مطابقة قريبة
        if (distance <= 2) {
          closeMatches.add(aya);
        }
      }
    }

    // ترتيب المطابقات القريبة حسب المسافة
    closeMatches.sort((a, b) {
      String textA = normalizeArabic(
          ArabicTools().removeTashkeel(a.ayaTextEmlaey.toLowerCase()));
      String textB = normalizeArabic(
          ArabicTools().removeTashkeel(b.ayaTextEmlaey.toLowerCase()));

      int distanceA = levenshteinDistance(normalizedQuery, textA);
      int distanceB = levenshteinDistance(normalizedQuery, textB);

      return distanceA.compareTo(distanceB);
    });

    // دمج النتائج: المطابقات التامة أولاً، ثم المطابقات القريبة
    List<AyatModel> searchResults = [...exactMatches, ...closeMatches];

    // تحديث الواجهة
    setState(() {
      ayatOfSearch2 = searchResults;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _speech.stop();
    super.dispose();
  }
}
