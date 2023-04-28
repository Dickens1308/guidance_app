import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/course_provider.dart';
import 'register_student.dart';

class ParentHome extends StatefulWidget {
  const ParentHome({Key? key}) : super(key: key);

  static const routeName = "/parent_home";

  @override
  State<ParentHome> createState() => _ParentHomeState();
}

class _ParentHomeState extends State<ParentHome> {
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
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
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
                  title: const Text('Parent Home'),
                  elevation: 0,
                  actions: [
                    IconButton(
                      onPressed: () =>
                          Provider.of<AuthProvider>(context, listen: false)
                              .logOutUser(context),
                      icon: const Icon(
                        Ionicons.log_in_outline,
                        size: 30,
                      ),
                    )
                  ],
                ),
                body: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DashboardTile(
                          size: size,
                          function: () {
                            Navigator.pushNamed(
                                context, RegisterStudent.routeName);
                          },
                          title: 'Add Student',
                          iconData: Icons.person),
                      const SizedBox(height: 50),
                      DashboardTile(
                          size: size,
                          function: () {},
                          title: 'Request report',
                          iconData: Icons.bar_chart),
                    ],
                  ),
                ),
              );
      },
    );
  }
}

class DashboardTile extends StatelessWidget {
  const DashboardTile({
    super.key,
    required this.size,
    required this.function,
    required this.title,
    required this.iconData,
  });

  final Size size;
  final Function function;
  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => function(),
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: size.height * .2,
        width: size.width * .4,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Icon(
              iconData,
              size: 100,
              color: Colors.white,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
