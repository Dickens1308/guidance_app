// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guidance/providers/course_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../screens/home.dart';
import '../screens/login.dart';
import '../screens/parent_home.dart';
import '../services/auth_service.dart';
import '../services/network_service.dart';

class AuthProvider extends ChangeNotifier {
  final authService = AuthService();
  final connectionState = NetworkService();

  bool _isLoading = false;
  final bool _isLogged = false;

  AppUser? _appUser;
  String _errorMessage = "";

  //Function to login user
  Future<void> loginUser(
      String email, String password, BuildContext context) async {
    setIsLoading(true);

    try {
      bool isConnected = await connectionState.checkConnection();

      if (!isConnected) {
        flutterToastFun('Check you internet connection!', Colors.red);
      }

      AppUser? appUser =
          isConnected ? await authService.signIn(email, password) : null;

      if (kDebugMode) {
        print(appUser!.user!.email);
      }

      if (appUser != null) {
        setUser(appUser);
        flutterToastFun(appUser.message!, Colors.black);
        setAppUserFromSharePref(appUser);

        if (appUser.user!.parentId != null) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
        } else {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(ParentHome.routeName, (route) => false);
        }
      }

      setIsLoading(false);
    } catch (e) {
      if (e.toString().contains('login failed')) {
        flutterToastFun('Email and/or password is incorrect', Colors.red);
      } else {}
      setIsLogged(false);
      setIsLoading(false);
    }
  }

  Future<void> registerUser(String username, String email, String password,
      BuildContext context) async {
    setIsLoading(true);

    try {
      bool isConnected = await connectionState.checkConnection();

      if (!isConnected) {
        Fluttertoast.showToast(
          msg: "Check you internet connection!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

      AppUser? appUser = isConnected
          ? await authService.signUp(username, email, password)
          : null;
      if (kDebugMode) {
        print(appUser);
      }

      if (appUser != null) {
        setUser(appUser);
        flutterToastFun(appUser.message!, Colors.black);
        setAppUserFromSharePref(appUser);

        Navigator.of(context)
            .pushNamedAndRemoveUntil(ParentHome.routeName, (route) => false);
      }

      setIsLoading(false);
    } catch (e) {
      setErrorMessage(e.toString());
      setIsLogged(false);
      setIsLoading(false);
      flutterToastFun(errorMessage, Colors.red);
    }
  }

  String _message = '';

  String get message => _message;

  setMessage(String value) {
    _message = value;
    notifyListeners();
  }

  Future<bool> resetPassword(String email, BuildContext context) async {
    setIsLoading(true);

    try {
      bool isConnected = await connectionState.checkConnection();

      if (!isConnected) {
        Fluttertoast.showToast(
          msg: "Check you internet connection!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

      String? message = isConnected ? await authService.resetPassword(email) : null;
      setIsLoading(false);
      setMessage(message??'');
      return true;
    } catch (e) {
      setErrorMessage(e.toString());
      setIsLogged(false);
      setIsLoading(false);
      flutterToastFun("Failed to reset this user account", Colors.red);

      return false;
    }
  }

  Future<void> registerStudent(String username, String email, String password,String age,
      BuildContext context) async {
    setIsLoading(true);

    try {
      bool isConnected = await connectionState.checkConnection();

      if (!isConnected) {
        Fluttertoast.showToast(
          msg: "Check you internet connection!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

      AppUser? appUser = isConnected
          ? await authService.signUpStudent(username, email, password,age,
              (await getAppUserFromSharePref())!.token.toString())
          : null;
      if (kDebugMode) {
        print(appUser);
      }

      if (appUser != null) {
        flutterToastFun(appUser.message!, Colors.black);

        Navigator.of(context).pop();
      }

      setIsLoading(false);
    } catch (e) {
      setErrorMessage(e.toString());
      setIsLogged(false);
      setIsLoading(false);
      if (e.toString().contains('email has already been taken')) {
        flutterToastFun('The email has already been taken', Colors.red);
      } else {
        flutterToastFun(errorMessage, Colors.red);
      }
    }
  }

  Future<void> logOutUser(BuildContext context) async {
    final provider = Provider.of<CourseProvider>(context, listen: false);
    try {
      provider.setLoading(true);
      String token = (await getAppUserFromSharePref())!.token.toString();
      authService.logOutUser(token).then((message) {
        provider.setLoading(false);
        setAppUserFromSharePrefLogout();
        Navigator.pushNamedAndRemoveUntil(
            context, LoginScreen.routeName, (route) => false);
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      provider.setLoading(false);
    }
  }

  AppUser? get appUser => _appUser;

  void setUser(AppUser user) {
    _appUser = user;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  void setIsLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  bool get isLogged => _isLogged;

  void setIsLogged(bool logged) {
    _isLoading = logged;
    notifyListeners();
  }

  String get errorMessage => _errorMessage;

  void setErrorMessage(String msg) {
    _errorMessage = msg;
    notifyListeners();
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

  Future<void> setAppUserFromSharePref(AppUser appUser) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (kDebugMode) {
      print("Shared pref name ${appUser.user!.name}");
    }

    preferences.setString('app_user', jsonEncode(appUser));
  }

  Future<void> setAppUserFromSharePrefLogout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('app_user', '');
  }

  Future<AppUser?> getAppUserFromSharePref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userPref = preferences.getString('app_user');

    if (userPref != '' && userPref != null) {
      final pref = jsonDecode(userPref);
      var appUser = AppUser.fromJson(pref);

      return appUser;
    }

    return null;
  }
}
