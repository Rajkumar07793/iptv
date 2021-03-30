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

  Future<Album> fetchAlbum() async {
    final response = await http.get('https://i.mjh.nz/PlutoTV/all.m3u8');
    setState(() {
      res = response;
    });
    if (response.statusCode == 200) {
      var data = Provider.of<Album>(context,listen: false);
      for (int i = 0; i < res.body.toString().split(' ').length; i++) {
        if (res.body.toString().split(' ')[i].contains('title'))
          data.title.add(res.body.toString().split(' ')[i].split('"')[1]);
        if (res.body.toString().split(' ')[i].contains('m3u8'))
          data.channel
              .add(res.body.toString().split(' ')[i].toString().split('\n')[1]);
        if (res.body.toString().split(' ')[i].contains('png'))
          data.image.add(res.body.toString().split(' ')[i].split('"')[1]);
      }
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
        child: (data.title != null)
            ? ListView.builder(
                itemCount: data.title.length,
                itemBuilder: (context, j) {
                  return ListTile(
                    title: Text(data.title[j].toString()),
                    leading: Image.network(data.image[j]),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => View(channel: data.channel[j]),
                        ),
                      );
                    },
                  );
                },
              ): Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
