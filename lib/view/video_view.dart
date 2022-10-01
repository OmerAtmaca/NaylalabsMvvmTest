import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  const VideoPage(
      {super.key,
      required this.thumbnail,
      required this.videoURL,
      required this.pageIndex,
      required this.currentIndex});
  final String videoURL;
  final int pageIndex;
  final int currentIndex;
  final String thumbnail;

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  bool _isPlay = true;
  late VideoPlayerController _controller;
  late Future _initializeVideoPlayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(widget.videoURL);
    _initializeVideoPlayer = _controller.initialize();
    _controller.setLooping(true);
    _controller.play();
    
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  void _pausePlay() {
    _isPlay ?_controller.pause(): _controller.play() ; 

    setState(() {
      _isPlay = !_isPlay;
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Container(
      color: Colors.black,
      child: FutureBuilder(
        future: _initializeVideoPlayer,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {

            return Center(
                child: CircularProgressIndicator(color: Colors.white));
          } else if (snapshot.connectionState == ConnectionState.done) {
            return GestureDetector(
              onTap: (() {
                _pausePlay();
              }),
              child: Stack(alignment: Alignment.center, children: [
                VideoPlayer(_controller),
                IconButton(
                  onPressed: () {},
                  icon:
                      Icon(_isPlay ? Icons.play_arrow : Icons.pause, size: 70),
                  color: Colors.white.withOpacity(_isPlay ? 0 : 0.5),
                )
              ]),
            );
          } else {
            return Container(
              color: Colors.red,
            );
          }
        },
      ),
    );
  }
}
