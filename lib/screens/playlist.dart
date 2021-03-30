import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iptv/models/playlist.dart';
import 'package:flutter_hls_parser/flutter_hls_parser.dart';
import 'package:iptv/screens/homepage.dart';
import 'package:iptv/screens/view.dart';
import 'package:provider/provider.dart';

class PlayList extends StatefulWidget {
  @override
  _PlayListState createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  var res;
  String channel = '';
  List title = [];
  List image = [];
  List channel1 = [];

  Future<Album> fetchAlbum() async {
    final response = await http.get('https://i.mjh.nz/PlutoTV/all.m3u8');
    setState(() {
      res = response;
    });
    if (response.statusCode == 200) {
      // var data = Provider.of<Album>(context,listen: false);
      // for (int i = 0; i < res.body.toString().split(' ').length; i++) {
      // setState(() {
      //   if (res.body.toString().split(' ')[i].contains('title'))
      //     title.add(res.body.toString().split(' ')[i].split('"')[1]);
      //   if (res.body.toString().split(' ')[i].contains('m3u8'))
      //     channel1
      //         .add(res.body.toString().split(' ')[i].toString().split('\n')[1]);
      //   if (res.body.toString().split(' ')[i].contains('png'))
      //     image.add(res.body.toString().split(' ')[i].split('"')[1]);
      // });}
      // print(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    var data = context.watch<Album>();
    return Scaffold(
      body: SafeArea(
        child: (res != null)
            ? ListView.builder(
                itemCount: res.body.toString().split(' ').length,
                itemBuilder: (context, i) {
                  return Column(children: [
                      if (res.body.toString().split(' ')[i].contains('title'))
                  Text(res.body.toString().split(' ')[i].split('"')[1]),
                  if (res.body.toString().split(' ')[i].contains('m3u8'))
                  GestureDetector(onTap: (){
                    Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => View(channel: res.body.toString().split(' ')[i].toString().split('\n')[1]),
                              ),
                            );
                  },child: Text(res.body.toString().split(' ')[i].toString().split('\n')[1])),
                  // if (res.body.toString().split(' ')[i].contains('png'))
                  // Image.network(res.body.toString().split(' ')[i].split('"')[1]),
                  ],);
                  // return ListTile(
                  //   title: Text(title[j].toString()),
                  //   leading: Image.network(data.image[j]),
                  //   onTap: () {
                  //     Navigator.of(context).push(
                  //       MaterialPageRoute(
                  //         builder: (context) => View(channel: channel[j]),
                  //       ),
                  //     );
                  //   },
                  // );
                },
              ): Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
