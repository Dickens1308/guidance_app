// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../widgets/email_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);
  static const routeName = '/reset_password';

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _emailController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final focusNodeE = FocusNode();
  bool message = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, notifier, child) {
        return notifier.isLoading
            ? Scaffold(
                body: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: CupertinoActivityIndicator(
                      radius: 15,
                      color: Colors.white54,
                    ),
                  ),
                ),
              )
            : SafeArea(
                top: true,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * .3,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .25,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Image.asset(
                                      'assets/images/WhatsApp Image 2023-05-15 at 09.23.24.jpeg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: MediaQuery.of(context).size.height * .7,
                              decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.lightBlueAccent,
                                      Theme.of(context)
                                          .primaryColor
                                          .withOpacity(.7),
                                    ],
                                    stops: const [
                                      0.1,
                                      0.9
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 30),
                                child: Form(
                                  key: globalKey,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 150),
                                      TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.done,
                                        controller: _emailController,
                                        validator: (input) => input!
                                                .isValidEmail()
                                            ? null
                                            : "check your email if is correct",
                                        style: const TextStyle(
                                          color: Colors.black87,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "Enter your email address",
                                          hintStyle: const TextStyle(
                                              color: Colors.black38,
                                              fontSize: 18),
                                          fillColor: Colors.white,
                                          filled: true,
                                          focusedBorder:
                                              buildOutlineInputBorder(),
                                          enabledBorder:
                                              buildOutlineInputBorder(),
                                          border: buildOutlineInputBorder(),
                                        ),
                                      ),
                                      if (message)
                                        Column(
                                          children:  [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 15),
                                              child: Text(
                                                notifier.message.toString(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      const SizedBox(height: 15),
                                      _buttonField(notifier),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: MediaQuery.of(context).size.height * .3,
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(100),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.white54,
      ),
      gapPadding: 10,
    );
  }

  Widget _buttonField(AuthProvider notifier) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: SizedBox(
        width: 300,
        height: 55,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: ElevatedButton(
            onPressed: () async {
              setState(() {
                message = false;
              });
              if (globalKey.currentState!.validate()) {
                globalKey.currentState!.save();

                bool isFinish = await notifier.resetPassword(
                  _emailController.text,
                  context,
                );

                if (isFinish) {
                  setState(() {
                    message = true;
                  });
                }
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, elevation: 0),
            child: Text(
              'Recover',
              style: Theme.of(context).textTheme.headlineSmall!.merge(
                    const TextStyle(
                      color: Color(0xff376577),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
