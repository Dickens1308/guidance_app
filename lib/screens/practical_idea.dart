// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/topic.dart';
import '../providers/question_provider.dart';
import '../widgets/screen_loader.dart';
import 'learn_question.dart';

class PracticalIDE extends StatefulWidget {
  const PracticalIDE({Key? key, required this.topic}) : super(key: key);

  final Topic topic;

  static const routeName = "/practical_idea";

  @override
  State<PracticalIDE> createState() => _PracticalIDEState();
}

class _PracticalIDEState extends State<PracticalIDE> {
  Topic? topic;
  int countCode = 0;

  String? value = "";
  String? valueCorrect = "";

  String? value2 = "";
  String? valueCorrect2 = "";

  String? value3 = "";
  String? valueCorrect3 = "";

  String? value4 = "";
  String? valueCorrect4 = "";

  String? value5 = "";
  String? valueCorrect5 = "";

  String? value6 = "";
  String? valueCorrect6 = "";

  String? value7 = "";
  String? valueCorrect7 = "";

  String? value8 = "";
  String? valueCorrect8 = "";

  String? value9 = "";
  String? valueCorrect9 = "";

  String? value10 = "";
  String? valueCorrect10 = "";

  bool error = false;
  String message = "";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      QuestionProvider provider =
          Provider.of<QuestionProvider>(context, listen: false);

      await provider.getAllQuestionById(context, widget.topic.id);
    });

    Future.delayed(Duration.zero, () => topic = widget.topic);
    Future.delayed(Duration.zero, () {
      if (topic != null && topic!.codeFirstLine != null) {
        countCode += 1;
        valueCorrect = topic!.codeFirstLine;
      }

      if (topic != null && topic!.codeSecondLine != null) {
        countCode += 1;
        valueCorrect2 = topic!.codeSecondLine;
      }

      if (topic != null && topic!.codeThirdLine != null) {
        countCode += 1;
        valueCorrect3 = topic!.codeThirdLine;
      }

      if (topic != null && topic!.codeFourthLine != null) {
        countCode += 1;
        valueCorrect4 = topic!.codeFourthLine;
      }

      if (topic != null && topic!.codeFifthLine != null) {
        countCode += 1;
        valueCorrect5 = topic!.codeFifthLine;
      }

      if (topic != null && topic!.codeSixLine != null) {
        countCode += 1;
        valueCorrect6 = topic!.codeSixLine;
      }

      if (topic != null && topic!.codeSevenLine != null) {
        countCode += 1;
        valueCorrect7 = topic!.codeSevenLine;
      }

      if (topic != null && topic!.codeEightLine != null) {
        countCode += 1;
        valueCorrect8 = topic!.codeEightLine;
      }

      if (topic != null && topic!.codeNineLine != null) {
        countCode += 1;
        valueCorrect9 = topic!.codeNineLine;
      }

      if (topic != null && topic!.codeTenLine != null) {
        countCode += 1;
        valueCorrect10 = topic!.codeTenLine;
      }

      if (kDebugMode) {
        print("************************************");
        print("count found is: $countCode");
        print("************************************");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionProvider>(
      builder: (context, provider, child) {
        return provider.loading
            ? const LoadingScreen()
            : Scaffold(
                appBar: AppBar(elevation: 0),
                bottomNavigationBar: BottomAppBar(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                            visible: error,
                            child: SizedBox(
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, bottom: 8),
                                  child: Text(
                                    message,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 50,
                                child: CupertinoButton(
                                  onPressed: () {
                                    setState(() {
                                      error = false;
                                      message = "";
                                      value = "";
                                      value2 = "";
                                      value3 = "";
                                      value4 = "";
                                      value5 = "";
                                      value6 = "";
                                      value7 = "";
                                      value8 = "";
                                      value9 = "";
                                      value10 = "";
                                    });
                                  },
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.6),
                                  child: const Text("Clear"),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: CupertinoButton(
                                  onPressed: () => _continueToQa(),
                                  color: Theme.of(context).primaryColor,
                                  child: const Text("Continue"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (topic != null)
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Test Code",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '${topic!.codeExample}',
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (topic != null &&
                            topic!.codeExample!.contains("variable"))
                          ideContainer(value, value2, value3, value4),
                        if (topic != null &&
                            !(topic!.codeExample!.contains("variable")))
                          ideOtherContainer(value, value2, value3, value4,
                              value5, value6, value7, value8, value9, value10),
                        if (topic != null) topicContent(context),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }

  Column topicContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if (topic!.codeFirstLine != null)
        //   codeContainer(topic!.codeFirstLine, true),
        if (topic!.codeSecondLine != null)
          codeContainer(topic!.codeSecondLine, false),
        if (topic!.codeThirdLine != null)
          codeContainer(topic!.codeThirdLine, false),
        if (topic!.codeFourthLine != null)
          codeContainer(topic!.codeFourthLine, false),
        if (topic!.codeFifthLine != null)
          codeContainer(topic!.codeFifthLine, false),
        if (topic!.codeSixLine != null)
          codeContainer(topic!.codeSixLine, false),
        if (topic!.codeSevenLine != null)
          codeContainer(topic!.codeSevenLine, false),
        if (topic!.codeEightLine != null)
          codeContainer(topic!.codeEightLine, false),
        if (topic!.codeNineLine != null)
          codeContainer(topic!.codeNineLine, false),
        if (topic!.codeTenLine != null)
          codeContainer(topic!.codeTenLine, false),
      ],
    );
  }

  codeContainer(String? code, bool firstLine) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (topic != null && topic!.codeExample!.contains("variable")) {
          _setDataCode(code);
        } else {
          _setDataCodeOther(code);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor,
        ),
        margin: const EdgeInsets.only(top: 10),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            code.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: firstLine ? 10 : 16,
            ),
          ),
        ),
      ),
    );
  }

  ideContainer(String? value, String? value2, String? value3, String? value4) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$value $value2 $value3 \n$value4",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ideOtherContainer(String? value, String? value2, String? value3,
      String? value4, value5, value6, value7, value8, value9, value10) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "\n$value \n$value2 \n$value3 \n$value4 \n$value5 \n$value6 \n$value7 \n$value8 \n$value9 \n$value10",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: Theme.of(context).primaryColor.withOpacity(0.5),
      ),
    );
  }

  _setDataCode(String? code) {
    if (value == "") {
      setState(() => value = code);
    } else if (value2 == "") {
      setState(() => value2 = code);
    } else if (value3 == "") {
      setState(() => value3 = code);
    } else if (value4 == "") {
      setState(() => value4 = code);
    } else if (value5 == "") {
      setState(() => value5 = code);
    } else if (value6 == "") {
      setState(() => value6 = code);
    } else if (value7 == "") {
      setState(() => value7 = code);
    } else if (value8 == "") {
      setState(() => value8 = code);
    } else if (value9 == "") {
      setState(() => value9 = code);
    } else if (value10 == "") {
      setState(() => value10 = code);
    }
  }

  _setDataCodeOther(String? code) {
    if (value == "" && valueCorrect2 != "") {
      setState(() => value = code);
    } else if (value2 == "" && valueCorrect3 != "") {
      setState(() => value2 = code);
    } else if (value3 == "" && valueCorrect4 != "") {
      setState(() => value3 = code);
    } else if (value4 == "" && valueCorrect5 != "") {
      setState(() => value4 = code);
    } else if (value5 == "" && valueCorrect6 != "") {
      setState(() => value5 = code);
    } else if (value6 == "" && valueCorrect7 != "") {
      setState(() => value6 = code);
    } else if (value7 == "" && valueCorrect8 != "") {
      setState(() => value7 = code);
    } else if (value8 == "" && valueCorrect9 != "") {
      setState(() => value8 = code);
    } else if (value9 == "" && valueCorrect10 != "") {
      setState(() => value9 = code);
    }
  }

  void _continueToQa() {
    setState(() {
      error = false;
      message = "";
    });
    if (topic != null && topic!.codeExample!.contains("variable")) {
      if (value == "" ||
          value != valueCorrect2 ||
          value2 == "" ||
          value2 != valueCorrect3 ||
          value3 == "" ||
          value3 != valueCorrect4) {
        setState(() {
          error = true;
          message =
              "Code is invalid make sure is: $valueCorrect2 $valueCorrect3 $valueCorrect4 \n\n$valueCorrect5";
        });
      } else {
        Navigator.pushNamed(context, QuestionsOnly.routeName, arguments: topic);
      }
    } else {
      if (countCode == 3) {
        if (value == "" ||
            value != valueCorrect2 ||
            value2 == "" ||
            value2 != valueCorrect3) {
          setState(() {
            error = true;
            message =
                "Code is invalid make sure is: $valueCorrect2 $valueCorrect3 $valueCorrect4 $valueCorrect5 $valueCorrect6 $valueCorrect7 $valueCorrect8 $valueCorrect9 $valueCorrect10";
          });
        } else {
          Navigator.pushNamed(context, QuestionsOnly.routeName,
              arguments: topic);
        }
      } else if (countCode == 4) {
        if (value == "" ||
            value != valueCorrect2 ||
            value2 == "" ||
            value2 != valueCorrect3 ||
            value3 == "" ||
            value3 != valueCorrect4) {
          setState(() {
            error = true;
            message =
                "Code is invalid make sure is: $valueCorrect2 $valueCorrect3 $valueCorrect4 $valueCorrect5 $valueCorrect6 $valueCorrect7 $valueCorrect8 $valueCorrect9 $valueCorrect10";
          });
        } else {
          Navigator.pushNamed(context, QuestionsOnly.routeName,
              arguments: topic);
        }
      } else if (countCode == 5) {
        if (value == "" ||
            value != valueCorrect2 ||
            value2 == "" ||
            value2 != valueCorrect3 ||
            value3 == "" ||
            value3 != valueCorrect4 ||
            value4 == "" ||
            value4 != valueCorrect5) {
          setState(() {
            error = true;
            message =
                "Code is invalid make sure is: $valueCorrect2 $valueCorrect3 $valueCorrect4 $valueCorrect5 $valueCorrect6 $valueCorrect7 $valueCorrect8 $valueCorrect9 $valueCorrect10";
          });
        } else {
          Navigator.pushNamed(context, QuestionsOnly.routeName,
              arguments: topic);
        }
      } else if (countCode == 6) {
        if (value == "" ||
            value != valueCorrect2 ||
            value2 == "" ||
            value2 != valueCorrect3 ||
            value3 == "" ||
            value3 != valueCorrect4 ||
            value4 == "" ||
            value4 != valueCorrect5 ||
            value5 == "" ||
            value5 != valueCorrect6) {
          setState(() {
            error = true;
            message =
                "Code is invalid make sure is: $valueCorrect2 $valueCorrect3 $valueCorrect4 $valueCorrect5 $valueCorrect6 $valueCorrect7 $valueCorrect8 $valueCorrect9 $valueCorrect10";
          });
        } else {
          Navigator.pushNamed(context, QuestionsOnly.routeName,
              arguments: topic);
        }
      } else if (countCode == 7) {
        if (value == "" ||
            value != valueCorrect2 ||
            value2 == "" ||
            value2 != valueCorrect3 ||
            value3 == "" ||
            value3 != valueCorrect4 ||
            value4 == "" ||
            value4 != valueCorrect5 ||
            value5 == "" ||
            value5 != valueCorrect6 ||
            value6 == "" ||
            value6 != valueCorrect7) {
          setState(() {
            error = true;
            message =
                "Code is invalid make sure is: $valueCorrect2 $valueCorrect3 $valueCorrect4 $valueCorrect5 $valueCorrect6 $valueCorrect7 $valueCorrect8 $valueCorrect9 $valueCorrect10";
          });
        } else {
          Navigator.pushNamed(context, QuestionsOnly.routeName,
              arguments: topic);
        }
      } else if (countCode == 8) {
        if (value == "" ||
            value != valueCorrect2 ||
            value2 == "" ||
            value2 != valueCorrect3 ||
            value3 == "" ||
            value3 != valueCorrect4 ||
            value4 == "" ||
            value4 != valueCorrect5 ||
            value5 == "" ||
            value5 != valueCorrect6 ||
            value6 == "" ||
            value6 != valueCorrect7 ||
            value7 == "" ||
            value7 != valueCorrect8) {
          setState(() {
            error = true;
            message =
                "Code is invalid make sure is: $valueCorrect2 $valueCorrect3 $valueCorrect4 $valueCorrect5 $valueCorrect6 $valueCorrect7 $valueCorrect8 $valueCorrect9 $valueCorrect10";
          });
        } else {
          Navigator.pushNamed(context, QuestionsOnly.routeName,
              arguments: topic);
        }
      } else if (countCode == 9) {
        if (value == "" ||
            value != valueCorrect2 ||
            value2 == "" ||
            value2 != valueCorrect3 ||
            value3 == "" ||
            value3 != valueCorrect4 ||
            value4 == "" ||
            value4 != valueCorrect5 ||
            value5 == "" ||
            value5 != valueCorrect6 ||
            value6 == "" ||
            value6 != valueCorrect7 ||
            value7 == "" ||
            value7 != valueCorrect8 ||
            value8 == "" ||
            value8 != valueCorrect9) {
          setState(() {
            error = true;
            message =
                "Code is invalid make sure is: $valueCorrect2 $valueCorrect3 $valueCorrect4 $valueCorrect5 $valueCorrect6 $valueCorrect7 $valueCorrect8 $valueCorrect9 $valueCorrect10";
          });
        } else {
          Navigator.pushNamed(context, QuestionsOnly.routeName,
              arguments: topic);
        }
      } else if (countCode == 10) {
        if (value == "" ||
            value != valueCorrect2 ||
            value2 == "" ||
            value2 != valueCorrect3 ||
            value3 == "" ||
            value3 != valueCorrect4 ||
            value4 == "" ||
            value4 != valueCorrect5 ||
            value5 == "" ||
            value5 != valueCorrect6 ||
            value6 == "" ||
            value6 != valueCorrect7 ||
            value7 == "" ||
            value7 != valueCorrect8 ||
            value8 == "" ||
            value8 != valueCorrect9 ||
            value9 == "" ||
            value9 != valueCorrect10) {
          setState(() {
            error = true;
            message =
                "Code is invalid make sure is: $valueCorrect2 $valueCorrect3 $valueCorrect4 $valueCorrect5 $valueCorrect6 $valueCorrect7 $valueCorrect8 $valueCorrect9 $valueCorrect10";
          });
        } else {
          Navigator.pushNamed(context, QuestionsOnly.routeName,
              arguments: topic);
        }
      }
    }
  }
}
