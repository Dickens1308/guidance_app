// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/course.dart';
import '../models/language.dart';
import '../models/user.dart';
import '../services/course_service.dart';
import '../services/network_service.dart';

class CourseProvider extends ChangeNotifier {
  final connectionState = NetworkService();
  final courseService = CourseService();

  final List<Course> _list = [];

  List<Course> get list => _list;

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setList(List<Course> value) {
    _list.clear();
    _list.addAll(value);
    notifyListeners();
  }

  void updateCourseList(Course course) {
    course.progressCount = course.progressCount! + 1;

    if (kDebugMode) {
      print(course.progressCount);
    }
    // _list[_list.indexWhere((cs) => cs.id == course.id)] = course;
    // notifyListeners();
  }

  final List<Language> _languageList = [];

  List<Language> get languageList => _languageList;

  setLanguageList(List<Language> value) {
    _languageList.clear();
    _languageList.addAll(value);
    notifyListeners();
  }

  Future<void> getAllLanguage(BuildContext context) async {
    setLoading(true);
    if (await connectionState.checkConnection()) {
      List<Language> tempList = await courseService.getAllLanguage(
          context, (await getTokenPref()).toString());

      setLanguageList(tempList);

      setLoading(false);
    } else {
      setLoading(false);
    }
  }

  Future<void> getAllCourse(BuildContext context, num number) async {
    setLoading(true);
    if (await connectionState.checkConnection()) {
      List<Course> tempList = await courseService.getAllCourse(
          context, number, (await getTokenPref()).toString());
      setList(tempList);

      setLoading(false);
    } else {
      setLoading(false);
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
