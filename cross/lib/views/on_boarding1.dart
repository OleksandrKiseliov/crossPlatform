import 'package:flutter/material.dart';
import 'package:to_bee/views/on_boarding.dart';
import 'package:to_bee/views/on_boarding2.dart';

class OnBoarding1 extends StatefulWidget {
  const OnBoarding1({super.key});

  @override
  State<OnBoarding1> createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
          SizedBox(height: 50,),

          Image.asset("lib/assets/images/Group310.png")
            ,SizedBox(height: 10,
            ),
            Container(
                width: 304,
                height:78,


                child: Column(
                  children: [
                    Text("Welcome",style:TextStyle(color:Color(0xff333333),fontSize:20,fontWeight: FontWeight.bold )),
                    SizedBox(height: 1,),
                    Text("Start your journey now",style:TextStyle(color:Color(0xff333333),fontSize:20,fontWeight: FontWeight.bold)),

                  ],
                )),

            Container(
                width: 365,
                height:108,


                child: Column(
                  children: [
                    Text("Control your day with ToBee.",style:TextStyle(color:Color(0xff707070),fontSize:18.5,fontWeight: FontWeight.bold)),

                    Text("Easily organize your tasks,set",style:TextStyle(color:Color(0xff707070),fontSize:18.5,fontWeight: FontWeight.bold)),

                    Text("reminders,achieve goals.",style:TextStyle(color:Color(0xff707070),fontSize:18.5,fontWeight: FontWeight.bold)),

                  ],
                ))
            ,Padding(
              padding: const EdgeInsets.all(10),
              child: Container(

                child: Row (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                  IconButton(onPressed:(){ Navigator.push(context  , MaterialPageRoute(builder:(context )=>OnBoarding()));}
                      , icon:Icon(Icons.arrow_circle_left_outlined,size: 40,color: Color(0xffFE6C00),)),
                  SizedBox(width:20),
                  IconButton(onPressed:(){ Navigator.push(context  , MaterialPageRoute(builder:(context )=>OnBoarding2()));}
                      , icon:Icon(Icons.arrow_circle_right,size: 40,color: Color(0xffFE6C00),)),


                ]

                ),
              ),
            )


          ],



        )




    );
  }
}
