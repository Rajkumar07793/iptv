import 'package:flutter/material.dart';

class Album with ChangeNotifier{
  List title = [];
  List image = [];
  List channel = [];

  void addTitle(title){
    this.title= title;
    notifyListeners();
  }

  void addImage(image){
    this.image= image;
    notifyListeners();
  }

  void addChannel(channel){
    this.channel= channel;
    notifyListeners();
  }
}
