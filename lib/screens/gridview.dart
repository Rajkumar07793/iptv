import 'package:flutter/material.dart';
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
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    dynamic response = context.watch<GetPlaylist>();
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: (){
      //   print(response.title.length);
      //   print(response.image.length);
      //   print(response.channel.length);
      // },),
      body: GridView.count(
        crossAxisCount: 5,mainAxisSpacing: 2,crossAxisSpacing: 2,
        children: [
          for (int i = 0; i < response.image.length; i++)
        // if (response.toString().split(' ')[i].contains('png'))
            GestureDetector(onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>View(channel: response.channel[i])));
            },
              child: Container(
                color: Colors.amberAccent,
                // child: Text(response.image[i]),
                child: Image.network(response.image[i]),
              ),
            )
        ],
      ),
    );
  }
}
