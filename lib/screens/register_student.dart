// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../widgets/age_field.dart';
import '../widgets/email_field.dart';
import '../widgets/password_field.dart';
import '../widgets/username_field.dart';

class RegisterStudent extends StatefulWidget {
  const RegisterStudent({Key? key}) : super(key: key);
  static const routeName = '/register_student';

  @override
  _RegisterStudentState createState() => _RegisterStudentState();
}

class _RegisterStudentState extends State<RegisterStudent> {
  final _usernameController = TextEditingController(text: 'Dickens Anthony');
  final _emailController =
      TextEditingController(text: 'dickens.anthony@gmail.com');
  final _passwordController = TextEditingController(text: 'password');
  final _ageController = TextEditingController(text: '12');

  final focusNodeU = FocusNode();
  final focusNodeE = FocusNode();
  final focusNodeA = FocusNode();
  final focusNodeP = FocusNode();

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool viewPassword = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, notifier, child) {
      return notifier.isLoading
          ? const Scaffold(
              body: Center(
                child: CupertinoActivityIndicator(radius: 15),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: const Text('Register child'),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 50, horizontal: 20),
                      child: Form(
                        key: globalKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 100),
                            UsernameFieldForm(
                              controller: _usernameController,
                              focusNode: focusNodeU,
                            ),
                            const SizedBox(height: 10),
                            EmailFieldForm(
                              controller: _emailController,
                              focusNode: focusNodeE,
                            ),
                            const SizedBox(height: 10),
                            AgeFieldForm(
                              controller: _ageController,
                              focusNode: focusNodeA,
                            ),
                            const SizedBox(height: 10),
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
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                    _buttonField(notifier),
                  ],
                ),
              ),
            );
    });
  }

  Widget _buttonField(AuthProvider notifier) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 15, right: 20, bottom: 20),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            if (globalKey.currentState!.validate()) {
              globalKey.currentState!.save();

              notifier.registerStudent(
                _usernameController.text,
                _emailController.text,
                _passwordController.text,
                _ageController.text,
                context,
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
          ),
          child: Text(
            'Register',
            style: Theme.of(context).textTheme.headlineSmall!.merge(
                  const TextStyle(color: Colors.white),
                ),
          ),
        ),
      ),
    );
  }
}
