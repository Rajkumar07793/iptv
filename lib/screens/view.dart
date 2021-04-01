import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yoyo_player/yoyo_player.dart';

import 'chrome_cast.dart';

class View extends StatefulWidget {
  final channel;

  View({Key key, @required this.channel}) : super(key: key);

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    print(orientation);
    if (orientation == Orientation.landscape)
      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    else
      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return Scaffold(
      // floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: (){
      //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CastSample()));
      // },),
      body: SafeArea(
        child: YoYoPlayer(
          aspectRatio: 16 / 9,
          url: widget.channel,
          videoStyle: VideoStyle(
            play: Icon(Icons.play_arrow),
            pause: Icon(Icons.pause),
            fullscreen: Icon(Icons.fullscreen),
            forward: Icon(Icons.skip_next),
            backward: Icon(Icons.skip_previous),
          ),
          videoLoadingStyle: VideoLoadingStyle(),
        ),
      ),
    );
  }
}