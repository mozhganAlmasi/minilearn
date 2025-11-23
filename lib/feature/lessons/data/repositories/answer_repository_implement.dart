import 'dart:convert';
import 'package:educationofchildren/core/error/failures.dart';
import 'package:educationofchildren/feature/lessons/data/models/answer_model.dart';
import 'package:educationofchildren/feature/lessons/data/models/answer_result_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnswerRepositoryImplement {
  static const String key = "quiz_data";

  /// دریافت تمام پاسخ‌ها
  Future<Either<Failure, List<AnswerModel>>> getAnswers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(key);

      if (jsonString == null) {
        return Right([]);
      }

      final List<dynamic> jsonList = jsonDecode(jsonString);
      final answers = jsonList
          .map((jsonItem) => AnswerModel.fromJson(jsonItem))
          .toList();

      return Right(answers);
    } catch (e) {
      return Left(CacheFailure('Error reading data: $e'));
    }
  }

  /// اضافه کردن یا به‌روزرسانی نتیجه یک پاسخ
  Future<Either<Failure, bool>> addAnswerResult({
    required AnswerModel answer,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(key);

      List<AnswerModel> data = [];

      if (jsonString != null) {
        final List<dynamic> jsonList = jsonDecode(jsonString);
        data = jsonList.map((jsonItem) => AnswerModel.fromJson(jsonItem)).toList();
      }

      // پیدا کردن پاسخ موجود با quizID
      final index = data.indexWhere((item) => item.quizID == answer.quizID);

      if (index != -1) {
        // به‌روزرسانی existing userAnswer
        data[index].userAnswer.addAll(answer.userAnswer);
        // اگر می‌خوای duplicate نشه، می‌توانیم filter کنیم
      } else {
        data.add(answer);
      }

      final encoded = data.map((a) => a.toJson()).toList();
      await prefs.setString(key, jsonEncode(encoded));
      return const Right(true);
    } catch (e) {
      return Left(CacheFailure('Error saving answer: $e'));
    }
  }

  /// حذف همه داده‌ها
  Future<Either<Failure, bool>> removeAllAnswer() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(key);
      return const Right(true);
    } catch (e) {
      return Left(CacheFailure('Error removing all answers: $e'));
    }
  }

  /// حذف یک آیتم با quizID خاص
  Future<Either<Failure, bool>> removeAnswerWithID(String quizID) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(key);

      if (jsonString == null) {
        return Left(CacheFailure("No data found"));
      }

      final List<dynamic> jsonList = jsonDecode(jsonString);
      final data = jsonList.map((jsonItem) => AnswerModel.fromJson(jsonItem)).toList();

      data.removeWhere((item) => item.quizID == quizID);

      final encoded = data.map((a) => a.toJson()).toList();
      await prefs.setString(key, jsonEncode(encoded));

      return const Right(true);
    } catch (e) {
      return Left(CacheFailure('Error deleting item: $e'));
    }
  }

  Future<Either<Failure, bool>> markAnswerDone(String quizID) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(key);

      if (jsonString == null) {
        return Left(CacheFailure("No data found"));
      }

      List<dynamic> data = jsonDecode(jsonString);

      // پیدا کردن رکورد با quizID
      final index = data.indexWhere((item) => item["id"] == quizID);
      if (index != -1) {
        data[index]["done"] = true; // یا "true" اگر رشته ذخیره می‌کنید
        await prefs.setString(key, jsonEncode(data));
        return const Right(true);
      } else {
        return Left(CacheFailure("Quiz not found"));
      }
    } catch (e) {
      return Left(CacheFailure("Error updating done: $e"));
    }
  }
}
