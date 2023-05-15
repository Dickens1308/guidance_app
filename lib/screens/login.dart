// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../widgets/email_field.dart';
import '../widgets/password_field.dart';
import 'register.dart';
import 'reset_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool viewPassword = true;
  final focusNodeU = FocusNode();
  final focusNodeE = FocusNode();
  final focusNodeP = FocusNode();

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
                                    vertical: 5, horizontal: 50),
                                child: Form(
                                  key: globalKey,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: Text(
                                          'Welcome to',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .merge(
                                                const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Text(
                                          'Children Career Guidance App',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .merge(
                                                const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                        ),
                                      ),
                                      Text(
                                        'Based on Programming',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .merge(
                                              const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                      ),
                                      const SizedBox(height: 30),
                                      EmailFieldForm(
                                        controller: _emailController,
                                        focusNode: focusNodeE,
                                      ),
                                      PasswordFieldForm(
                                        controller: _passwordController,
                                        viewPassword: viewPassword,
                                        function: () {
                                          setState(() {
                                            viewPassword = !viewPassword;
                                          });
                                        },
                                        focusNode: focusNodeP,
                                      ),
                                      const SizedBox(height: 25),
                                      _buttonField(notifier),
                                      const SizedBox(height: 20),
                                      GestureDetector(
                                        onTap: () => Navigator.pushNamed(
                                            context, ResetPassword.routeName),
                                        behavior: HitTestBehavior.opaque,
                                        child: SizedBox(
                                          child: Center(
                                            child: RichText(
                                              text: const TextSpan(
                                                text: 'Forgot password? ',
                                                style: TextStyle(
                                                  color: Colors.white54,
                                                  fontSize: 20,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: 'Reset here',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      GestureDetector(
                                        onTap: () => Navigator.pushNamed(
                                            context, RegisterScreen.routeName),
                                        behavior: HitTestBehavior.opaque,
                                        child: SizedBox(
                                          child: Center(
                                            child: RichText(
                                              text: const TextSpan(
                                                text:
                                                    'Do not have an account? ',
                                                style: TextStyle(
                                                  color: Colors.white54,
                                                  fontSize: 20,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: 'Sign up',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 250,
                            child: Container(
                              height: 90,
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

  Widget _buttonField(AuthProvider notifier) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: SizedBox(
        width: 300,
        height: 55,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: ElevatedButton(
            onPressed: () {
              if (globalKey.currentState!.validate()) {
                globalKey.currentState!.save();

                notifier.loginUser(
                  _emailController.text,
                  _passwordController.text,
                  context,
                );
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, elevation: 0),
            child: Text(
              'Sign in',
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
