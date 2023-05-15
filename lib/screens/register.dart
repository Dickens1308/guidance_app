// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../widgets/email_field.dart';
import '../widgets/password_field.dart';
import '../widgets/username_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const routeName = '/register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final focusNodeU = FocusNode();
  final focusNodeE = FocusNode();
  final focusNodeP = FocusNode();

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool viewPassword = true;

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
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 10, right: 10),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * .28,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.asset(
                                  'assets/images/WhatsApp Image 2023-05-15 at 09.23.27.jpeg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: MediaQuery.of(context).size.height * .68,
                              decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.lightBlueAccent,
                                      Theme.of(context)
                                          .primaryColor
                                          .withOpacity(.7),
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
                                      const SizedBox(height: 40),
                                      UsernameFieldForm(
                                          controller: _usernameController,
                                          focusNode: focusNodeU),
                                      EmailFieldForm(
                                          controller: _emailController,
                                          focusNode: focusNodeE),
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
                                      const SizedBox(height: 20),
                                      _buttonField(notifier),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 260,
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

  Widget _buttonField(AuthProvider notifier) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 50, right: 50),
      child: SizedBox(
        width: 300,
        height: 55,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: ElevatedButton(
            onPressed: () {
              if (globalKey.currentState!.validate()) {
                globalKey.currentState!.save();

                notifier.registerUser(
                  _usernameController.text,
                  _emailController.text,
                  _passwordController.text,
                  context,
                );
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, elevation: 0),
            child: Text(
              'Sign up',
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
