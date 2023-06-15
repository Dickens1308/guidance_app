// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/course.dart';
import '../models/topic.dart';
import '../models/user.dart';
import '../services/network_service.dart';
import '../services/topic_service.dart';

class TopicProvider extends ChangeNotifier {
  final connectionState = NetworkService();
  final topicService = TopicService();

  final List<Topic> _list = [];

  List<Topic> get list => _list;

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setList(List<Topic> value) {
    _list.clear();
    _list.addAll(value);
    notifyListeners();
  }

  void updateCourseList(Course course) {
    // course.progressCount = course.progressCount! + 1;
    //
    // if (kDebugMode) {
    //   print(course.progressCount);
    // }
    // _list[_list.indexWhere((cs) => cs.id == course.id)] = course;
    // notifyListeners();
  }

  Future<void> getAllTopic(BuildContext context, num number) async {
    setLoading(true);
    if (await connectionState.checkConnection()) {
      List<Topic> tempList = await topicService.getAllTopics(
          context, number, (await getTokenPref()).toString());
      setList(tempList);

      setLoading(false);
    } else {
      setLoading(false);
    }
    try {} catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<String?> getTokenPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userPref = preferences.getString('app_user');

    if (userPref != '' && userPref != null) {
      final pref = jsonDecode(userPref);
      var appUser = AppUser.fromJson(pref);

      return appUser.token;
    } else {
      return null;
    }
  }

  void flutterToastFun(String msg, Color color) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
