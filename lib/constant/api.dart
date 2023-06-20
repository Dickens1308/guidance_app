// ignore_for_file: constant_identifier_names

class Api {
  static const BASE = 'http://172.16.36.138:8000/api/v1';
  // static const BASE = 'http://192.168.50.122:8000/api/v1';

  static const GET_ALL_COURSES = '$BASE/language/courses';
  static const GET_ALL_TOPICS = '$BASE/language/topics';
  static const GET_ALL_LANG = '$BASE/language/';
  static const LOGIN_USER = '$BASE/auth/login';
  static const RESET_USER_PASSWORD = '$BASE/auth/reset/password';
  static const REGISTER_USER = '$BASE/auth/register';
  static const REGISTER_STUDENT = '$BASE/child/register';
  static const LOGOUT_USER = '$BASE/auth/logout';
  static const QUESTION_ANSWERED = '$BASE/language/question/answer';
  static const GET_ALL_QUESTION = '$BASE/language/get_questions';
  static const GET_RESULTS = '$BASE/courses/get_results';
  static const GET_REPORT = '$BASE/language/get_reports';
  static const GET_CHILDREN = '$BASE/language/children';
}
