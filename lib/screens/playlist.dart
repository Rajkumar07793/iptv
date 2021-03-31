import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iptv/models/playlist.dart';
import 'package:flutter_hls_parser/flutter_hls_parser.dart';
import 'package:iptv/screens/homepage.dart';
import 'package:iptv/screens/view.dart';
import 'package:iptv/services/api/get_playlist.dart';
import 'package:provider/provider.dart';

import 'gridview.dart';

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
      // print(response.body);
      // var data = Provider.of<Album>(context,listen: false);
      // for (int i = 0; i < res.body.toString().split(' ').length; i++)
      // {
      // setState(() {
      //   if (res.body.toString().split(' ')[i].contains('title'))
      //     title.add(res.body.toString().split(' ')[i].split('"')[1]);
      //   if (res.body.toString().split(' ')[i].contains('m3u8'))
      //     channel1
      //         .add(res.body.toString().split(' ')[i].toString().split('\n')[1]);
      //   if (res.body.toString().split(' ')[i].contains('png'))
      //     image.add(res.body.toString().split(' ')[i].split('"')[1]);
      // });
      //   }
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
    var data = context.watch<GetPlaylist>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GridView1()));
      },),
      body: SafeArea(
        child: (res != null)
            ? ListView.builder(
                itemCount: res.body.toString().split(' ').length,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      if (res.body.toString().split(' ')[i].contains('title'))
                        Text(
                          res.body.toString().split(' ')[i].split('"')[1],
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      if (res.body.toString().split(' ')[i].contains('m3u8'))
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => View(
                                      channel: res.body
                                          .toString()
                                          .split(' ')[i]
                                          .toString()
                                          .split('\n')[1]),
                                ),
                              );
                            },
                            child: Text(res.body
                                .toString()
                                .split(' ')[i]
                                .toString()
                                .split('\n')[1])),
                      SizedBox(
                        height: 20,
                      ),
                      if (res.body.toString().split(' ')[i].contains('png'))
                        GestureDetector(onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => View(
                                  channel: res.body
                                      .toString()
                                      .split(' ')[i]
                                      .toString()
                                      .split('\n')[1]),
                            ),
                          );
                        },
                          child: SizedBox(height: 50,
                              child: Image.network(res.body
                                  .toString()
                                  .split(' ')[i]
                                  .split('"')[1],fit: BoxFit.fill,)),
                        ),
                    ],
                  );
              //     return ListTile(
              //       title: Text(title[0].toString()),
              //       leading: Image.network(data.image[0]),
              //       onTap: () {
              //         Navigator.of(context).push(
              //           MaterialPageRoute(
              //             builder: (context) => View(channel: channel[0]),
              //           ),
              //         );
              //       },
              //     );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
