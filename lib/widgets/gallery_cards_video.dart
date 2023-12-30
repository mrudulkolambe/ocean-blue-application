import 'package:flutter/material.dart';
import 'package:ocean_blue/models/gallery.dart';
import 'package:video_player/video_player.dart';

class GalleryCardVideo extends StatefulWidget {
  final Gallery data;

  const GalleryCardVideo({super.key, required this.data});

  @override
  State<GalleryCardVideo> createState() => _GalleryCardVideoState();
}

class _GalleryCardVideoState extends State<GalleryCardVideo> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.data.url))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_controller.value.isPlaying) {
                        setState(() {
                          _isPlaying = false;
                        });
                        _controller.pause();
                      } else {
                        setState(() {
                          _isPlaying = true;
                        });
                        _controller.play();
                      }
                    },
                    child: AspectRatio(
                      aspectRatio: 4 / 5,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: 185,
                          height: 100,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                    ),
                  ),
                  if (!_isPlaying)
                    GestureDetector(
                      onTap: () {
                        if (_controller.value.isPlaying) {
                          setState(() {
                            _isPlaying = false;
                          });
                          _controller.pause();
                        } else {
                          setState(() {
                            _isPlaying = true;
                          });
                          _controller.play();
                        }
                      },
                      child: AspectRatio(
                        aspectRatio: 4 / 5,
                        child: Center(
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white.withOpacity(0.2)),
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              )),
        ],
      ),
    );
  }
}
