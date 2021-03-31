import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iptv/screens/playlist.dart';
import 'package:yoyo_player/yoyo_player.dart';

class View extends StatelessWidget {
  final channel;
  View({Key key, @required this.channel}):super(key: key);
  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    print(orientation);
    if(orientation==Orientation.landscape)
      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    else SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return Scaffold(
      // floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: (){
      //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PlayList()));
      // },),
      body: SafeArea(
        child: YoYoPlayer(
          aspectRatio: 16 / 9,
          url: channel,
          videoStyle: VideoStyle(),
          videoLoadingStyle: VideoLoadingStyle(),
        ),
      ),
    );
  }
}
