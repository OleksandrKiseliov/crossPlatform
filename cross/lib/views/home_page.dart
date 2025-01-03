

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color(0xffFFD3B2),
      body:SingleChildScrollView(
        child: Column(

          children: [
        SizedBox(height: 20,),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:[

        SizedBox(width:100),
            Container(
          width: 130.32,
        height: 103.04,
          child: Image.asset("lib/assets/images/Group305.png",fit:BoxFit.fill)),

            SizedBox(width:30),
            GestureDetector(onTap: (){},
        child: Container(width:39,height:39,
            child: Image.asset
            ("lib/assets/images/mdi_bell-notification.png"),
        ),
            ),
        SizedBox(width: 30,)
          ]








        ),

        Container(
        width:430,height:614,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(35),color: Color(0xffFFFFFF)),
child:SingleChildScrollView(
  child: Column(
    children: [
      SizedBox(height: 40,),
      Column(
        children: [
          Text("Daily tasks",style: TextStyle(color: Color(0xff29221D),fontWeight: FontWeight.w600,fontSize: 20))
      






        ],








      )
      
      
      
      
      
      
      
      
    ],
    
    
    
  ),
),
          
          
          
          
          
          
          


            )


          ],





        ),
      )
    );
  }
}
