import 'package:animation/src/widgets/cat.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{

  @override
  State createState() {
    return HomeState();
  }
}

class HomeState extends State<Home>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: buildAnimation(),
    );
  }

  Widget buildAnimation(){
    return Cat();
  }
}