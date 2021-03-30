import 'package:flutter/material.dart';
import 'package:iptv/models/playlist.dart';
import 'package:iptv/screens/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Album()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IP TV',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
