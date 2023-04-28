import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

class CourseVideoItem extends StatefulWidget {
  const CourseVideoItem({Key? key, required this.videoUrl, required this.index})
      : super(key: key);

  final String videoUrl;
  final int index;

  @override
  State<CourseVideoItem> createState() => _CourseVideoItemState();
}

class _CourseVideoItemState extends State<CourseVideoItem> {
  ChewieController? chewieController;
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    super.initState();
    initChewieController();
  }

  Future<void> initChewieController() async {
    if (mounted) {
      videoPlayerController = VideoPlayerController.network(widget.videoUrl);
      await videoPlayerController!.initialize();
      setState(() {});
    }

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      autoPlay: widget.index == 0 ? true : false,
      customControls: const CupertinoControls(
        backgroundColor: Color(0xff152238),
        iconColor: Colors.white,
      ),
      showControlsOnInitialize: false,
      errorBuilder: (context, errorMessage) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Failed to play the video',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    videoPlayerController!.dispose();
    chewieController!.videoPlayerController.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (chewieController != null &&
            chewieController!.videoPlayerController.value.isInitialized)
        ? ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: MediaQuery.of(context).size.height * .3,
            width: double.infinity,
            color: Colors.transparent,
            child: Chewie(
                controller: chewieController!,
              ),
          ),
        )
        : SizedBox(
            height: MediaQuery.of(context).size.height * .3,
            width: double.infinity,
            child: Shimmer.fromColors(
              baseColor: Colors.black54,
              highlightColor: Colors.white54,
              child: Container(
                height: MediaQuery.of(context).size.height * .3,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          );
  }
}
