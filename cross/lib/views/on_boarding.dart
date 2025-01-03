import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_bee/views/on_boarding1.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,

        body: Stack(children: [
          Positioned(
            left: 320,
            right: 0,
            top: 0,
            bottom: 495,
            child:
            Container(width: 300,height:300,

                child: Image.asset("lib/assets/images/Ellipse.png")),
          ),

          Positioned(
              left:15,
              right:15,
              bottom:100 ,
              top: 100,

              child: Container(
                  width:440,
                  height:450.94,

                  child: Image.asset("lib/assets/images/Group25.png"))),
          Positioned(
            left:0 ,
            right:320,
            bottom:0 ,
            top:400,
            child:
            Container(width: 500,height:500,

                child: Image.asset("lib/assets/images/Ellipse2.png")),
          ),

          Positioned(
            left:15,
            right:15,
            bottom:0 ,
            top: 480,
            child: IconButton(onPressed:(){ Navigator.push(context  , MaterialPageRoute(builder:(context )=>OnBoarding1()));}
                , icon:Icon(Icons.arrow_circle_right,size: 40,color: Color(0xffFE6C00),)),
          )






        ]));

  }
}
