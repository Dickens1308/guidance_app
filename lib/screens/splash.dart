// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guidance/models/user.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'home.dart';
import 'login.dart';
import 'parent_home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const routeName = "/";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      checkIfSignedIn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  void checkIfSignedIn() async {
    AuthProvider provider = Provider.of<AuthProvider>(context, listen: false);
    AppUser? appUser = await provider.getAppUserFromSharePref();

    if (appUser != null) {
      if (kDebugMode) {
        print(appUser.user!.name);
      }

      provider.setUser(appUser);

      appUser.user!.parentId != null
          ? Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false)
          : Navigator.pushNamedAndRemoveUntil(
              context, ParentHome.routeName, (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.routeName, (route) => false);
    }
  }
}
