import 'package:flutter/material.dart';

import '../models/course.dart';

class CourseVideo extends StatefulWidget {
  const CourseVideo({Key? key, required this.course}) : super(key: key);

  final Course course;

  static const routeName = "/course_video";

  @override
  State<CourseVideo> createState() => _CourseVideoState();
}

class _CourseVideoState extends State<CourseVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Course tutorial"),
      ),
      // body: SingleChildScrollView(
      //   physics: const BouncingScrollPhysics(),
      //   child: Padding(
      //     padding: const EdgeInsets.all(15.0),
      //     child: Column(
      //       children: [
      //         ListView.builder(
      //           itemCount: widget.course.videos!.length,
      //           shrinkWrap: true,
      //           physics: const NeverScrollableScrollPhysics(),
      //           itemBuilder: (context, index) {
      //             return Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text(
      //                   '${index + 1}. ${widget.course.videos![index].title!}',
      //                   style: const TextStyle(
      //                     fontSize: 18,
      //                     color: Colors.white70,
      //                   ),
      //                 ),
      //                 const SizedBox(height: 10),
      //                 CourseVideoItem(
      //                   videoUrl: widget.course.videos![index].location!,
      //                   index: index,
      //                 ),
      //                 const SizedBox(height: 20),
      //               ],
      //             );
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
