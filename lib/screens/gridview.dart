import 'package:flutter/material.dart';
import 'package:iptv/screens/playlist.dart';
import 'package:iptv/screens/view.dart';
import 'package:iptv/services/api/get_playlist.dart';
import 'package:provider/provider.dart';

class GridView1 extends StatefulWidget {
  @override
  _GridView1State createState() => _GridView1State();
}

class _GridView1State extends State<GridView1> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Please wait..."),
          // content: Center(child: CircularProgressIndicator(),),
        )
    ));
      createPlaylistState(context).whenComplete(() => Navigator.pop(context));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic response = context.watch<GetPlaylist>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PlayList()));
      },),
      body: GridView.count(
        crossAxisCount: 3,mainAxisSpacing: 2,crossAxisSpacing: 2,
        children: [
          for (int i = 0; i < response.channel.length; i++)
            GestureDetector(onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>View(channel: response.channel[i])));
            },
              child: Container(
                color: Colors.grey,
                // child: Text(response.image[i]),
                child: (response.image.length<response.channel.length)?Icon(Icons.image):Image.network(response.image[i]),
              ),
            ),
        ],
      ),
    );
  }
}
