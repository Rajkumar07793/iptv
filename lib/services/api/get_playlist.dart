import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<GetPlaylist> createPlaylistState(context) async {
  final http.Response response =
      await http.get('https://i.mjh.nz/PlutoTV/all.m3u8');

  if (response.statusCode == 200) {
    print(response.statusCode);
    // print(response.body);
    Provider.of<GetPlaylist>(context, listen: false).getResponse(response.body);
    // for (int i = 0; i < response.body.toString().split(' ').length; i++) {
    //   if (response.body.toString().split(' ')[i].contains('title'))
    //     Provider.of<GetPlaylist>(context, listen: false).getList1(response.body.toString().split(' ')[i].split('"')[1]);
    //   if (response.body.toString().split(' ')[i].contains('m3u8'))
    //     Provider.of<GetPlaylist>(context, listen: false).getList3(
    //         response.body.toString().split(' ')[i].toString().split('\n')[1]);
    //   if (response.body.toString().split(' ')[i].contains('png'))
    //     Provider.of<GetPlaylist>(context, listen: false).getList2(response.body.toString().split(' ')[i].split('"')[1]);
    // }
    // return getList(title: ,image: ,channel: );
    return null;
  } else {
    throw Exception('Failed to create album.');
  }
}

class GetPlaylist with ChangeNotifier{
  List title=[];
  List image=[];
  List channel=[];
  // List response=[];
  //
  // GetPlaylist([String title,String image, String channel]){
  //   this.title=title;
  //   this.image=image;
  //   this.channel=channel;
  //   notifyListeners();
  // }
  //
  // void getList1(title){
  //   // this.title.add(title);
  //   notifyListeners();
  //   print(title);
  // }
  //
  // void getList2(image){
  //   // this.image.add(image);
  //   notifyListeners();
  //   print(image);
  // }
  //
  // void getList3(channel){
  //   // this.channel.add(channel);
  //   notifyListeners();
  //   print(channel);
  // }

  void getResponse(res){
    // this.response=res;
    for (int i = 0; i < res.toString().split(' ').length; i++) {
      if (res.toString().split(' ')[i].contains('title'))
        // print(res.toString().split(' ')[i].split('"')[1]);
        this.title.add(res.toString().split(' ')[i].split('"')[1]);
      if (res.toString().split(' ')[i].contains('m3u8'))
        // print(res.toString().split(' ')[i].toString().split('\n')[1]);
        this.channel
            .add(res.toString().split(' ')[i].toString().split('\n')[1]);
      if (res.toString().split(' ')[i].contains('png'))
        // print(res.toString().split(' ')[i].split('"')[1]);
        this.image.add(res.toString().split(' ')[i].split('"')[1]);
    }
    notifyListeners();
  }
}