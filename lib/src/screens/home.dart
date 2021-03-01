import 'package:animation/src/widgets/cat.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  @override
  State createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;
  Animation<double> boxAnimation;
  AnimationController boxController;

  @override
  void initState() {
    super.initState();
    catController = AnimationController(
      duration: Duration(
        milliseconds: 300,
      ),
      vsync: this,
    );
    catAnimation = Tween(begin: -35.0, end: -80.0).animate(
      CurvedAnimation(parent: catController, curve: Curves.easeIn),
    );
    boxController = AnimationController(
      duration: Duration(
        milliseconds: 200,
      ),
      vsync: this,
    );
    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
      CurvedAnimation(parent: boxController, curve: Curves.easeInOut),
    );


    boxController.forward();
    boxAnimation.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        boxController.reverse();
      }else if(status == AnimationStatus.dismissed){
        boxController.forward();
      }
    });

  }

  onTap() {
    if (catController.status == AnimationStatus.dismissed) {
      boxController.stop();
      catController.forward();

    } else if (catController.status == AnimationStatus.completed) {
      catController.reverse();
      boxController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            children: [
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap(),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
        top: 5.0,
        left: 5.0,
        child: AnimatedBuilder(
          animation: boxAnimation,

          child: Container(
            height: 14.0,
            width: 90.0,
            color: Colors.brown,
          ),
          builder: (context, child) {
            return Transform.rotate(
              angle: boxAnimation.value,
              child: child,
              alignment: Alignment.topLeft,
            );
          },
        )
    );
  }

  Widget buildRightFlap() {
    return Positioned(
        top: 5.0,
        right: 5.0,
        child: AnimatedBuilder(
          animation: boxAnimation,

          child: Container(
            height: 14.0,
            width: 90.0,
            color: Colors.brown,
          ),
          builder: (context, child) {
            return Transform.rotate(
              angle: -boxAnimation.value,
              child: child,
              alignment: Alignment.topRight,
            );
          },
        )
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          left: 0.0,
          right: 0.0,
        );
      },
      child: Cat(),
    );
  }
}
 //github test