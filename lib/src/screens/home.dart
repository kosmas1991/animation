import 'package:animation/src/widgets/cat.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;

  @override
  void initState() {
    super.initState();
    catController = AnimationController(
      duration: Duration(
        seconds: 2,
      ),
      vsync: this,
    );
    catAnimation = Tween(begin: -50.0, end: -80.0).animate(
      CurvedAnimation(parent: catController, curve: Curves.easeIn),
    );
  }

  onTap() {
    if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
    }else if(catController.status == AnimationStatus.completed){
      catController.reverse();
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
              buildBox(),
              buildCatAnimation(),

            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget buildBox(){
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
