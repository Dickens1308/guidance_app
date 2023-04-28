import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/course_provider.dart';
import '../widgets/grid_tile_lan.dart';
import '../widgets/screen_loader.dart';
import 'course_videos.dart';

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
                            buildLearningContent(context, size, provider)
                          ],
                        ),
                      ),
                    ),
        );
      },
    );
  }

  buildLearningContent(
      BuildContext context, Size size, CourseProvider provider) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        CourseVideo.routeName,
        arguments: provider.list[0],
      ),
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * .7,
                child: Text(
                  'Learn Material',
                  style: Theme.of(context).textTheme.headlineSmall!.merge(
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '0 Materials',
                style: Theme.of(context).textTheme.bodyLarge!.merge(
                      const TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 20, right: 10, top: 7, bottom: 7),
              child: Icon(
                CupertinoIcons.play_arrow,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox buildNoLanguage(Size size) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
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
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome,',
                style: Theme.of(context).textTheme.bodyLarge!.merge(
                      const TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
              ),
              Text(
                '${provider.appUser!.user!.name}',
                style: Theme.of(context).textTheme.headlineSmall!.merge(
                      const TextStyle(
                        color: Colors.white,
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
