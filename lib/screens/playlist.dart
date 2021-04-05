import 'package:flutter/material.dart';
import 'package:iptv/services/api/get_playlist.dart';
import 'package:m3u/m3u.dart';
import 'package:provider/provider.dart';
import 'gridview.dart';

class PlayList extends StatefulWidget {
  @override
  _PlayListState createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  dynamic tracks;

  Future<void> parse() async {
    final fileContent = await context.watch<GetPlaylist>().response;
    final List<M3uGenericEntry> listOfTracks = await parseFile(fileContent);
    print("list of tracks" + listOfTracks.toString());
    setState(() {
      tracks = listOfTracks;
    });

    // Organized categories
    final categories =
        sortedCategories(entries: listOfTracks, attributeName: 'group-title');
    print("list of categories" + categories.toString());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    parse();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var data = context.watch<GetPlaylist>();
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(itemCount: tracks.length,itemBuilder: (context, index) {
          return Column(
            children: [
              Text(tracks[index].title.toString()),
              Text(tracks[index].link.toString()),
              // Text('')
            ],
          );
        }),
      ),
    );
  }
}
