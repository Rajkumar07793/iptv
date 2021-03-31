import 'package:flutter/material.dart';
import 'package:iptv/models/playlist.dart';
import 'package:iptv/screens/gridview.dart';
import 'package:iptv/screens/homepage.dart';
import 'package:iptv/screens/playlist.dart';
import 'package:iptv/services/api/get_playlist.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Album()),
    ChangeNotifierProvider(create: (_) => GetPlaylist()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AlertDialog();
    createPlaylistState(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IP TV',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GridView1(),
    );
  }
}
