import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_provider.dart';
import '../screens/course_videos.dart';
import 'course_slider_item.dart';
import 'dots.dart';

class CourseSlider extends StatefulWidget {
  const CourseSlider({Key? key, required this.courseProvider})
      : super(key: key);

  final CourseProvider courseProvider;

  @override
  State<CourseSlider> createState() => _CourseSliderState();
}

class _CourseSliderState extends State<CourseSlider> {
  CarouselController carouselController = CarouselController();
  // Course course = Course();
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    // course = Provider.of<CourseProvider>(context, listen: false).list[0];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CourseProvider provider = widget.courseProvider;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSliderContainer(size, provider),
        const SizedBox(height: 20),
        SizedBox(
          height: size.height * .02,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(provider.list.length, (idx) {
                return activeIndex == idx
                    ? const ActiveDot()
                    : const InactiveDot();
              })),
        ),
        const SizedBox(height: 55),
        Text(
          'Learn',
          style: Theme.of(context).textTheme.headlineMedium!.merge(
                const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        const SizedBox(height: 10),
        buildLearningContent(context, size, provider)
      ],
    );
  }

  SizedBox buildSliderContainer(Size size, CourseProvider provider) {
    return SizedBox(
      height: size.height * .47,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: CarouselSlider.builder(
          itemCount: provider.list.length,
          carouselController: carouselController,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  CourseSliderItem(
            course: provider.list[itemIndex],
          ),
          options: CarouselOptions(
              height: size.height * .44,
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: 0.8,
              // aspectRatio: 2.0,
              initialPage: 0,
              scrollDirection: Axis.horizontal,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              onPageChanged: (index, carouselPageChangedReason) {
                setState(() {
                  activeIndex = index;
                  // course = provider.list[index];
                });
              }),
        ),
      ),
    );
  }

  buildLearningContent(
      BuildContext context, Size size, CourseProvider provider) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        CourseVideo.routeName,
        arguments: provider.list[activeIndex],
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
                  'View tutorial',
                  style: Theme.of(context).textTheme.headlineSmall!.merge(
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                ),
              ),
              const SizedBox(height: 10),
              // Text(
              //   '${course.videosCount.toString()} videos',
              //   style: Theme.of(context).textTheme.bodyLarge!.merge(
              //         const TextStyle(
              //           color: Colors.white60,
              //           fontWeight: FontWeight.w400,
              //         ),
              //       ),
              // ),
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
}
