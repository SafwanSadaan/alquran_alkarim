// ignore_for_file: file_names

class AyatModel {
  final int id;
  final int jozz;
  final int suraNo;
  final String suraNameEn;
  final String suraNameAr;
  final int page;
  final int lineStart;
  final int lineEnd;
  final int ayaNo;
  final String ayaText;
  final String ayaTextEmlaey;

  bool accepting;

  AyatModel({
    required this.id,
    required this.jozz,
    required this.suraNo,
    required this.suraNameEn,
    required this.suraNameAr,
    required this.page,
    required this.lineStart,
    required this.lineEnd,
    required this.ayaNo,
    required this.ayaText,
    required this.ayaTextEmlaey,
    this.accepting = false,
  });

  factory AyatModel.fromJson(Map<String, dynamic> json) {
    return AyatModel(
      id: json['id'] ?? 0, // Default to 0 if null
      jozz: json['jozz'] ?? 0, // Default to 0 if null
      suraNo: json['sura_no'] ?? 0, // Default to 0 if null
      suraNameEn: json['sura_name_en'] ?? '', // Default to empty string if null
      suraNameAr: json['sura_name_ar'] ?? '', // Default to empty string if null
      page: json['page'] ?? 0, // Default to 0 if null
      lineStart: json['line_start'] ?? 0, // Default to 0 if null
      lineEnd: json['line_end'] ?? 0, // Default to 0 if null
      ayaNo: json['aya_no'] ?? 0, // Default to 0 if null
      ayaText: json['aya_text'] ?? '', // Default to empty string if null
      ayaTextEmlaey:
          json['aya_text_emlaey'] ?? '', // Default to empty string if null
      accepting: json['accepting'] ?? false, // Default to false if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jozz': jozz,
      'sura_no': suraNo,
      'sura_name_en': suraNameEn,
      'sura_name_ar': suraNameAr,
      'page': page,
      'line_start': lineStart,
      'line_end': lineEnd,
      'aya_no': ayaNo,
      'aya_text': ayaText,
      'aya_text_emlaey': ayaTextEmlaey,
      'accepting': accepting,
    };
  }
}
