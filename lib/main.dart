import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'providers/auth_provider.dart';
import 'providers/course_provider.dart';
import 'providers/question_provider.dart';
import 'providers/topic_provider.dart';

void main() async {
  Paint.enableDithering = true;
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xff152238),
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Color(0xff152238),
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<TopicProvider>(
          create: (_) => TopicProvider(),
        ),
        ChangeNotifierProvider<QuestionProvider>(
          create: (_) => QuestionProvider(),
        ),
        ChangeNotifierProvider<CourseProvider>(
          create: (_) => CourseProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
