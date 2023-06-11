// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/course.dart';
import '../models/progress.dart';
import '../models/question.dart';
import '../models/result_model.dart';
import '../models/user.dart';
import '../services/course_service.dart';
import '../services/network_service.dart';

class QuestionProvider extends ChangeNotifier {
  final connectionState = NetworkService();
  final courseService = CourseService();

  int? _choice;

  int? get choice => _choice;

  setChoice(int? value) {
    _choice = value;
    setWrong(false);
    notifyListeners();
  }

  int _position = 0;

  int get position => _position;

  setPosition(int value) {
    _position = value;
    notifyListeners();
  }

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final List<Question> _questionList = [];

  List<Question> get questionList => _questionList;

  void setQuestionList(List<Question> value) {
    _questionList.clear();
    _questionList.addAll(value);
    notifyListeners();
  }

  Future<void> getAllQuestionById(BuildContext context, num id) async {
    try {
      setLoading(true);
      if (await connectionState.checkConnection()) {
        List<Question> tempList = await courseService.getQuestionsByCourseId(
            context, id, (await getTokenPref()).toString());

        setQuestionList(tempList);
        setLoading(false);
      } else {
        setLoading(false);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setLoading(false);
    }
  }

  final List<String> _myList = [];

  List<String> get myList => _myList;

  setMyList(Question question) {
    _myList.clear();

    _myList.add(question.choiceOne!);
    _myList.add(question.choiceTwo!);
    _myList.add(question.choiceThree!);

    notifyListeners();
  }

  bool _wrong = false;

  bool get wrong => _wrong;

  setWrong(bool value) {
    _wrong = value;
    notifyListeners();
  }

  updateQuestionList(num id, Progress progress) {
    _questionList[_questionList.indexWhere((e) => e.id == id)]
        .progress!
        .add(progress);

    notifyListeners();
  }

  Future<bool> answerQuestionAndGoNext(
      BuildContext context, Question question) async {
    bool toReturn = false;
      String answer = _choice == 0
          ? 'a'
          : _choice == 1
              ? 'b'
              : 'c';

      if (question.correctAnswer == answer) {
        setWrong(false);
        setLoading(true);
        String response = await courseService.sendAnswer(
          context,
          question.id!,
          _choice == 0
              ? 'a'
              : _choice == 1
                  ? 'b'
                  : 'c',
          (await getTokenPref()).toString(),
        );

        if (response.contains("saved")) {
          setLoading(false);
          loadingScreen(context);
          await Future.delayed(const Duration(milliseconds: 1300), () {
            Navigator.of(context).pop();
            toReturn = true;
          });
        } else {
          flutterToastFun(response, Colors.grey);
          setLoading(false);
        }
      } else {
        setWrong(true);
        if (kDebugMode) {
          print("Wrong answer");
        }
      }
    try {
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setLoading(false);
    }

    return toReturn;
  }

  ResultModel? _resultModel;

  ResultModel? get resultModel => _resultModel;

  setResultModel(ResultModel value) {
    if (kDebugMode) {
      print(value.correct);
    }
    _resultModel = value;
    if (value.questions!.isNotEmpty) {
      setQuestionList(value.questions!);
    }
    notifyListeners();
  }

  Future<void> getAllResultById(BuildContext context, num id) async {
    try {
      setLoading(true);
      if (await connectionState.checkConnection()) {
        ResultModel? resultModel = await courseService.getResultsByCourseId(
            context, id, (await getTokenPref()).toString());

        if (resultModel != null) {
          setResultModel(resultModel);
        }
        setLoading(false);
      } else {
        setLoading(false);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
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

  Future loadingScreen(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          child: Center(
            child: Lottie.asset(
              'assets/json/1818-success-animation.json',
            ),
          ),
        );
      },
    );
  }
}
