import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/course_provider.dart';
import '../widgets/screen_loader.dart';

class LanguageTopic extends StatefulWidget {
  const LanguageTopic({Key? key}) : super(key: key);


  @override
  State<LanguageTopic> createState() => _LanguageTopicState();
}

class _LanguageTopicState extends State<LanguageTopic> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CourseProvider>(
      builder: (context, provider, child) {
        return provider.loading ? const LoadingScreen() : const Scaffold();
      },
    );
  }
}
