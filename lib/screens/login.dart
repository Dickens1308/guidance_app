// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../widgets/email_field.dart';
import '../widgets/password_field.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController =
      TextEditingController(text: 'dickens.anthony@gmail.com');
  final _passwordController = TextEditingController(text: 'password');

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
            : Scaffold(
                appBar: AppBar(elevation: 0),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .3,
                              child: const Icon(
                                Icons.person,
                                size: 250,
                                color: Colors.white54,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Sign in to Continue',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .merge(
                                      const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Form(
                          key: globalKey,
                          child: Column(
                            children: [
                              EmailFieldForm(controller: _emailController),
                              PasswordFieldForm(
                                controller: _passwordController,
                                viewPassword: viewPassword,
                                function: () {
                                  setState(() {
                                    viewPassword = !viewPassword;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      _buttonField(notifier),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, RegisterScreen.routeName),
                        behavior: HitTestBehavior.opaque,
                        child: SizedBox(
                          height: 80,
                          width: double.infinity,
                          child: Center(
                            child: RichText(
                              text: const TextSpan(
                                text: 'Do not have an account? ',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 20,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Sign up',
                                    style: TextStyle(
                                      color: Colors.deepPurple,
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
              );
      },
    );
  }

  Widget _buttonField(AuthProvider notifier) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 20),
      child: SizedBox(
        width: double.infinity,
        height: 55,
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
            backgroundColor: Colors.deepPurple,
          ),
          child: Text(
            'Sign in',
            style: Theme.of(context).textTheme.headlineSmall!.merge(
                  const TextStyle(color: Colors.white),
                ),
          ),
        ),
      ),
    );
  }
}
