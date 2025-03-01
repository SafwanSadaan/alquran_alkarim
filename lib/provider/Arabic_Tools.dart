// ignore_for_file: file_names

class ArabicTools {
  bool isItTashkeel(int char) {
    switch (String.fromCharCode(char)) {
      case 'َ':
      case 'ِ':
      case 'ُ':
      case 'ً':
      case 'ٍ':
      case 'ٌ':
      case 'ْ':
      case 'ّ':
        return true;
    }
    return false;
  }

  List<List> findWawPlural(String string) {
    string = "    $string    ";
    final List<List> result = [];
    for (int i = 3; i < string.length; i++) {
      if (String.fromCharCode(string.codeUnitAt(i)) != ' ') {
        int a = string.codeUnitAt(i); //first letter
        int b = string.codeUnitAt(i + 1); //second letter
        int c = string.codeUnitAt(i + 2); //third letter

        if (String.fromCharCode(a) == "و" &&
            String.fromCharCode(b) == "ا" &&
            String.fromCharCode(c) == " ") {
          String res = "";
          for (int k = i + 1; k < string.length; k--) {
            if (String.fromCharCode(string.codeUnitAt(k)) != " ") {
              res = String.fromCharCode(string.codeUnitAt(k)) + res;
            } else {
              break;
            }
          }
          result.add([res, i - res.length, i]);
        }
      }
    }
    if (result.isEmpty) {
      return [
        ["-1"]
      ];
    } else {
      return result;
    }
  }

  bool isItArabicChar(int char) {
    if (char >= 1568 && char <= 1610) {
      return true;
    }
    return false;
  }

  String removeTashkeel(String string) {
    List<String> tashkeel = ["َ", "ِ", "ُ", "ٌ", "ً", "ٍ", "ْ", "ّ"];
    for (int i = 0; i < tashkeel.length; i++) {
      string = string.replaceAll(tashkeel[i], "");
    }
    return string;
  }

  String addTashkeelToChar(int whichHarakah, int char) {
    // this will take a code unit of char to add fatha , and return string char + fatha
    String fatha = "";
    switch (whichHarakah) {
      case 1:
        {
          fatha = "${String.fromCharCode(char)}َ";
        }
        break;
      case 2:
        {
          fatha = "${String.fromCharCode(char)}ُ";
        }
        break;
      case 3:
        {
          fatha = "${String.fromCharCode(char)}ِ";
        }
        break;
      case 4:
        {
          fatha = "${String.fromCharCode(char)}ّ";
        }
        break;
      case 5:
        {
          fatha = "${String.fromCharCode(char)}ً";
        }
        break;
      case 6:
        {
          fatha = "${String.fromCharCode(char)}ٌ";
        }
        break;
      case 7:
        {
          fatha = "${String.fromCharCode(char)}ٍ";
        }
        break;
      case 8:
        {
          fatha = "${String.fromCharCode(char)}ْ";
        }
        break;
      default:
        {
          fatha = "null";
        }
        break;
    }
    return fatha;
  }

  String addTashkeelToLastString(int whichHarakah, String string) {
    // this will take a code unit of char to add fatha , and return string char + fatha
    String fatha = "";
    switch (whichHarakah) {
      case 1:
        {
          fatha = "$stringَ";
        }
        break;
      case 2:
        {
          fatha = "$stringُ";
        }
        break;
      case 3:
        {
          fatha = "$stringِ";
        }
        break;
      case 4:
        {
          fatha = "$stringّ";
        }
        break;
      case 5:
        {
          fatha = "$stringً";
        }
        break;
      case 6:
        {
          fatha = "$stringٌ";
        }
        break;
      case 7:
        {
          fatha = "$stringٍ";
        }
        break;
      default:
        {
          fatha = "null";
        }
        break;
    }
    return fatha;
  }
}
