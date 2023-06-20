import 'package:flutter/material.dart';
import 'package:guidance/models/user.dart';
import 'package:provider/provider.dart';

import '../providers/course_provider.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  static const routeName = '/report_progress';

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  User? _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final provider = Provider.of<CourseProvider>(context, listen: false);
      await provider.getAllChildren(context).then((value) async {
        if (provider.userList.isNotEmpty) {
          _user = provider.userList.first;
          await provider.getReport(context, provider.userList.first.id!);
        }
      });
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
                        const SizedBox(height: 40),
                        if (provider.userList.isNotEmpty)
                          Container(
                            // height: 60,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: DropdownButtonFormField<User>(
                              value: _user,
                              onChanged: (value) {
                                setState(() {
                                  _user = value;
                                });
                                provider.getReport(context, value!.id!);
                              },
                              dropdownColor: Theme.of(context).primaryColor,
                              iconSize: 30,
                              iconEnabledColor: Colors.white,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Children",
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white70,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white70,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 20,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(15),
                              hint: const Text('Select child'),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .merge(
                                    const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                              items: provider.userList.map((User option) {
                                return DropdownMenuItem<User>(
                                  value: option,
                                  child: Text(option.name!),
                                );
                              }).toList(),
                            ),
                          ),
                        if (provider.report != null &&
                            provider.report!.pythonQuestion > 0)
                          getLangCol(
                            "Python Report",
                            provider.report!.pythonQuestion,
                            provider.report!.pythonAnswers,
                            provider.report!.pythonCorrectCount,
                          ),
                        if (provider.report != null &&
                            provider.report!.scratchQuestion > 0)
                          getLangCol(
                            "Scratch Report",
                            provider.report!.scratchQuestion,
                            provider.report!.scratchAnswers,
                            provider.report!.scratchCorrectCount,
                          ),
                        if (provider.report != null &&
                            provider.report!.rubyQuestion > 0)
                          getLangCol(
                            "Ruby Report",
                            provider.report!.rubyQuestion,
                            provider.report!.rubyAnswers,
                            provider.report!.rubyCorrectCount,
                          ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }

  Column getLangCol(String title, num question, num answer, num correct) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Correct Answers: $correct',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Wrong Answers: ${answer - correct}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Total Answers: $answer',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Total Questions: $question',
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
