import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/course_provider.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  static const routeName = '/report_progress';

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final provider = Provider.of<CourseProvider>(context, listen: false);
      await provider.getReport(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<CourseProvider>(
      builder: (context, provider, child) {
        return provider.loading
            ? Scaffold(
                body: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: const Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: Colors.white),
                        SizedBox(height: 20),
                        Text(
                          'please wait ...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  title: const Text('Report'),
                  elevation: 0,
                ),
                body: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: Column(
                      children: [
                        if (provider.report != null && provider.report!.pythonQuestion > 0)
                          getLangCol(
                            "Python Report",
                            provider.report!.pythonQuestion,
                            provider.report!.pythonAnswers,
                          ),
                        if (provider.report != null && provider.report!.scratchQuestion > 0)
                          getLangCol(
                            "Scratch Report",
                            provider.report!.scratchQuestion,
                            provider.report!.scratchAnswers,
                          ),
                        if (provider.report != null && provider.report!.rubyQuestion > 0)
                          getLangCol(
                            "Ruby Report",
                            provider.report!.rubyQuestion,
                            provider.report!.rubyAnswers,
                          ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }

  Column getLangCol(String title, num question, num answer) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                  height: 10,
                  width: MediaQuery.of(context).size.width,
                  child: ProgressBar(
                    usedValue: answer,
                    totalValue: question,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'A: $answer',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Q: $question',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProgressBar extends StatelessWidget {
  final num usedValue;
  final num totalValue;

  const ProgressBar(
      {super.key, required this.usedValue, required this.totalValue});

  @override
  Widget build(BuildContext context) {
    double progress = usedValue / totalValue;

    return LinearProgressIndicator(
      value: progress,
      backgroundColor: Colors.grey[300],
      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
    );
  }
}
