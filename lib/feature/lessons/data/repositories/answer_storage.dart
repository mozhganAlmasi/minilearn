import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AnswerStorage {
  static const String key = "quiz_data";

  /// اضافه کردن نتیجه جدید
  static Future<void> addResult({
    required String id,
    required String isdone,
    required String quizeindex,
    required String iscurrect,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);

    List<dynamic> data = [];
    if (jsonString != null) {
      data = jsonDecode(jsonString);
    }

    // آیا id موجود است؟
    final existing = data.firstWhere(
          (item) => item["id"] == id,
      orElse: () => null,
    );

    if (existing != null) {
      //اگر آن id وجود داشت این قسمت اجرا می شود
      // و همچنین اگر در آن id همان ایندکس قبلا مقدار داشته باشد دوباره ذخیره نمی شود
      final isDuplicate = existing["result"].any(
            (r) => r["quizeindex"] == quizeindex,
      );

      if (!isDuplicate) {
        existing["result"].add({
          "quizeindex": quizeindex,
          "iscurrect": iscurrect,
        });

      }

    } else {
      // ایجاد آیتم جدید
      data.add({
        "id": id,
        "done":isdone,
        "result": [
          {"quizeindex": quizeindex, "iscurrect": iscurrect}
        ]
      });
    }

    await prefs.setString(key, jsonEncode(data));
  }
  static Future<void> changeDone(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);

    if (jsonString == null) return;

    List<dynamic> data = jsonDecode(jsonString);

    for (var item in data) {
      if (item["id"] == id) {
        item["done"] = "true";
        break;
      }
    }

    await prefs.setString(key, jsonEncode(data));
  }
  /// دریافت کل داده‌ها
  static Future<List<dynamic>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString == null) return [];
    return jsonDecode(jsonString);
  }

  /// حذف تمام داده‌ها
  static Future<void> removeAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  /// حذف فقط یک آیتم با id مشخص
  static Future<void> remove(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);

    if (jsonString == null) return;

    List<dynamic> data = jsonDecode(jsonString);
    data.removeWhere((item) => item["id"] == id);

    await prefs.setString(key, jsonEncode(data));
  }
}
