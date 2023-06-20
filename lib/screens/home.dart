import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/course_provider.dart';
import '../widgets/grid_tile_lan.dart';
import '../widgets/screen_loader.dart';
import 'recommends.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int langIndex = 0;
  String language = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CourseProvider>(context, listen: false)
          .getAllLanguage(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<CourseProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          bottomNavigationBar: BottomAppBar(
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recommendations Books',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pushNamed(
                          context, RecommendationScreen.routeName),
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          body: provider.loading
              ? const LoadingScreen()
              : provider.languageList.isEmpty
                  ? buildNoLanguage(size)
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 50),
                            buildAppBar(
                              context,
                              size,
                            ),
                            const SizedBox(height: 25),
                            GridView.builder(
                              itemCount: provider.languageList.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 30,
                              ),
                              itemBuilder: (context, index) {
                                final language = provider.languageList[index];
                                return GridTileLan(
                                  size: size,
                                  language: language,
                                );
                              },
                            ),
                            SizedBox(
                              height: size.height * .23,
                            ),
                            // buildLearningContent(context, size, provider)
                          ],
                        ),
                      ),
                    ),
        );
      },
    );
  }

  SizedBox buildNoLanguage(Size size) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No Language found',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Please try to refresh page or contact support team for assistance',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white54,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildAppBar(BuildContext context, Size size) {
    final provider = Provider.of<AuthProvider>(context, listen: false);

    return SizedBox(
      height: size.height * .08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${provider.appUser!.user!.name}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                '${provider.appUser!.user!.age} Years Old',
                style: Theme.of(context).textTheme.bodyLarge!.merge(
                      const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              ),
            ],
          ),
          IconButton(
            onPressed: () => Provider.of<AuthProvider>(context, listen: false)
                .logOutUser(context),
            icon: const Icon(
              Ionicons.log_in_outline,
              color: Colors.white,
              size: 40,
            ),
          )
        ],
      ),
    );
  }
}
