import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iptv/screens/playlist.dart';
import 'package:yoyo_player/yoyo_player.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    print(orientation);
    if(orientation==Orientation.landscape)
      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    else SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PlayList()));
      },),
          body: SafeArea(
            child: YoYoPlayer(
              aspectRatio: 16 / 9,
              url: "https://multiplatform-f.akamaihd.net/i/multi/will/bunny/big_buck_bunny_,640x360_400,640x360_700,640x360_1000,950x540_1500,.f4v.csmil/master.m3u8",
              videoStyle: VideoStyle(),
              videoLoadingStyle: VideoLoadingStyle(),
  ),
          ),
    );
  }
}