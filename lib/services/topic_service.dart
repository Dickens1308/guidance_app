// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/api.dart';
import '../models/progress.dart';
import '../models/question.dart';
import '../models/result_model.dart';
import '../models/topic.dart';
import '../providers/question_provider.dart';
import '../screens/login.dart';

class TopicService {
  Future<List<Topic>> getAllTopics(
      BuildContext context, num number, String token) async {
    String url = '${Api.GET_ALL_TOPICS}/$number';
    Uri uri = Uri.parse(url);
    if (kDebugMode) {
      print('$url  $token');
    }

    List<Topic> topicList = [];

    final response = await http.get(
      uri,
      headers: {"accept": "application/json", "Authorization": "Bearer $token"},
    );

    if (kDebugMode) {
      print(response.statusCode);
    }

    if (response.statusCode == 200) {
      Iterable parsedListJson =
          await (jsonDecode(response.body)["topics"]) as List;

      List<Topic> list = parsedListJson.map((e) => Topic.fromJson(e)).toList();

      if (list.isNotEmpty) {
        topicList.addAll(list);
      }
    } else if (response.statusCode == 401) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('app_user', '');
      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.routeName, (route) => false);
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }

    return topicList;
  }

  Future<List<Question>> getQuestionsByCourseId(
      BuildContext context, num courseID, String token) async {
    String url = '${Api.GET_ALL_QUESTION}/$courseID';
    Uri uri = Uri.parse(url);
    if (kDebugMode) {
      print('$url  $token');
    }

    List<Question> questionList = [];

    final response = await http.get(
      uri,
      headers: {
        "accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        Iterable parsedListJson =
            await (jsonDecode(response.body)["questions"]) as List;

        List<Question> list =
            parsedListJson.map((e) => Question.fromJson(e)).toList();

        if (list.isNotEmpty) {
          if (kDebugMode) {
            print("The are ${list.length} questions");
          }
          return list;
        }
      }
    } else if (response.statusCode == 401) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('app_user', '');
      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.routeName, (route) => false);
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }

    return questionList;
  }

  Future<ResultModel?> getResultsByCourseId(
      BuildContext context, num courseID, String token) async {
    String url = '${Api.GET_RESULTS}/$courseID';
    Uri uri = Uri.parse(url);
    if (kDebugMode) {
      print('$url  $token');
    }

    final response = await http.get(
      uri,
      headers: {
        "accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final parsedJson = await (jsonDecode(response.body));

      ResultModel resultModel = ResultModel.fromJson(parsedJson);
      return resultModel;
    } else if (response.statusCode == 401) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('app_user', '');
      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.routeName, (route) => false);
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }

    return null;
  }

  Future<String> sendAnswer(BuildContext context, int questionID,
      String selectedAnswer, String token) async {
    String url = Api.QUESTION_ANSWERED;
    Uri uri = Uri.parse(url);
    if (kDebugMode) {
      print('$url  $token');
    }

    final response = await http.post(uri, headers: {
      "accept": "application/json",
      "Authorization": "Bearer $token",
    }, body: {
      "question_id": questionID.toString(),
      "choice_selected": selectedAnswer
    });

    if (response.statusCode == 200) {
      String parsedJson = await (jsonDecode(response.body)["message"]);
      dynamic res = await (jsonDecode(response.body)["progress"]);

      if (res != null && parsedJson.contains('Successful')) {
        Progress progress = Progress.fromJson(res);

        Provider.of<QuestionProvider>(context, listen: false)
            .updateQuestionList(questionID, progress);
      }

      return parsedJson;
    } else if (response.statusCode == 401) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('app_user', '');
      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.routeName, (route) => false);
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
    return '';
  }
}
