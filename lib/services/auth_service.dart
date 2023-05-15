import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constant/api.dart';
import '../models/user.dart';

class AuthService {
  Future<AppUser?> signIn(String email, String password) async {
    String url = Api.LOGIN_USER;
    Uri uri = Uri.parse(url);

    final response = await http.post(
      uri,
      headers: {
        "accept": "application/json",
      },
      body: {
        'email': email,
        'password': password,
      },
    );

    if (kDebugMode) {
      print("Trying to login user $url");
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> data = await jsonDecode(response.body);
      AppUser appUser = AppUser.fromJson(data);

      return appUser;
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<String> resetPassword(String email) async {
    String url = Api.RESET_USER_PASSWORD;
    Uri uri = Uri.parse(url);

    final response = await http.post(
      uri,
      headers: {
        "accept": "application/json",
      },
      body: {'email': email},
    );

    if (kDebugMode) {
      print("Reset user $url");
      print(response.body);
    }

    if (response.statusCode == 200) {
      return await jsonDecode(response.body)['message'];
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<AppUser?> signUp(
      String username, String email, String password) async {
    String url = Api.REGISTER_USER;
    Uri uri = Uri.parse(url);

    final response = await http.post(
      uri,
      headers: {
        "accept": "application/json",
      },
      body: {
        'username': username,
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final data = await (jsonDecode(response.body));
      AppUser appUser = AppUser.fromJson(data);

      if (kDebugMode) {
        print(appUser);
      }

      return appUser;
    } else {
      throw Exception(jsonDecode(response.body));
    }
  }

  Future<AppUser?> signUpStudent(
      String username, String email, String password, String? token) async {
    String url = Api.REGISTER_STUDENT;
    Uri uri = Uri.parse(url);

    if (kDebugMode) {
      print("The token is $token");
    }

    final response = await http.post(
      uri,
      headers: {"accept": "application/json", "Authorization": "Bearer $token"},
      body: {
        'username': username,
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final data = await (jsonDecode(response.body));
      AppUser appUser = AppUser.fromJson(data);

      if (kDebugMode) {
        print(appUser);
      }

      return appUser;
    } else {
      if (kDebugMode) {
        print(await jsonDecode(response.body));
      }
      throw Exception(await jsonDecode(response.body));
    }
  }

  Future<String?> logOutUser(String? token) async {
    String url = Api.LOGIN_USER;
    Uri uri = Uri.parse(url);

    final response = await http.post(
      uri,
      headers: {"accept": "application/json", "Authorization": "Bearer $token"},
    );

    if (kDebugMode) {
      print("Trying to logout user $url");
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> data = await jsonDecode(response.body);
      return data['message'];
    } else {
      return 'Failed to logout user';
    }
  }
}
