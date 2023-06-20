import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guidance/models/question.dart';
import 'package:guidance/screens/learn_question.dart';

import 'models/course.dart';
import 'models/language.dart';
import 'models/topic.dart';
import 'screens/course_screen.dart';
import 'screens/course_test.dart';
import 'screens/course_videos.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/parent_home.dart';
import 'screens/practical_idea.dart';
import 'screens/practical_screen.dart';
import 'screens/python_future.dart';
import 'screens/questions_list.dart';
import 'screens/recommends.dart';
import 'screens/register.dart';
import 'screens/register_student.dart';
import 'screens/report_screen.dart';
import 'screens/reset_password.dart';
import 'screens/results.dart';
import 'screens/splash.dart';
import 'screens/topic_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const _blackPrimaryValue = 0xff152238;

  static const MaterialColor _primarySwatch = MaterialColor(
    _blackPrimaryValue,
    <int, Color>{
      50: Color(_blackPrimaryValue),
      100: Color(_blackPrimaryValue),
      200: Color(_blackPrimaryValue),
      300: Color(_blackPrimaryValue),
      400: Color(_blackPrimaryValue),
      500: Color(_blackPrimaryValue),
      600: Color(_blackPrimaryValue),
      700: Color(_blackPrimaryValue),
      800: Color(_blackPrimaryValue),
      900: Color(_blackPrimaryValue),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      theme: ThemeData(
        primarySwatch: _primarySwatch,
        scaffoldBackgroundColor: const Color(0xff376577),
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case LoginScreen.routeName:
                return const LoginScreen();
              case RegisterScreen.routeName:
                return const RegisterScreen();
              case ResetPassword.routeName:
                return const ResetPassword();
              case ParentHome.routeName:
                return const ParentHome();
              case RecommendationScreen.routeName:
                return RecommendationScreen();
              case FutureScreen.routeName:
                final args = routeSettings.arguments as Language;
                return FutureScreen(language: args);
              case RegisterStudent.routeName:
                return const RegisterStudent();
              case ResultScreen.routeName:
                final args = routeSettings.arguments as Course;
                return ResultScreen(course: args);
              case CourseVideo.routeName:
                final args = routeSettings.arguments as Course;
                return CourseVideo(course: args);
              case CourseScreen.routeName:
                final args = routeSettings.arguments as Language;
                return CourseScreen(language: args);
              case TopicScreen.routeName:
                final args = routeSettings.arguments as Course;
                return TopicScreen(course: args);
              case CourseTest.routeName:
                final args = routeSettings.arguments as Question;
                return CourseTest(question: args);
              case QuestionListScreen.routeName:
                final args = routeSettings.arguments as Topic;
                return QuestionListScreen(topic: args);
              case QuestionsOnly.routeName:
                final args = routeSettings.arguments as Topic;
                return QuestionsOnly(topic: args);
              case ReportScreen.routeName:
                return const ReportScreen();
              case PracticalScreen.routeName:
                final args = routeSettings.arguments as Topic;
                return PracticalScreen(topic: args);
              case PracticalIDE.routeName:
                final args = routeSettings.arguments as Topic;
                return PracticalIDE(topic: args);
              case HomeScreen.routeName:
                return const HomeScreen();
              case SplashScreen.routeName:
              default:
                return const SplashScreen();
            }
          },
        );
      },
    );
  }
}
