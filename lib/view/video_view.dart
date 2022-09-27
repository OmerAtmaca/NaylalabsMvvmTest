import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tryproject/services/login_service.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key, required this.videoURL});
  final String videoURL;
  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller;
  late Future _initializeVideoPlayer;
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    

  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}