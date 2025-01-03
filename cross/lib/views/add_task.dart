import 'package:flutter/material.dart';
import 'package:to_bee/views/home.dart';
import 'package:to_bee/views/home_page.dart';
import 'package:to_bee/widgets/task_input_form.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
backgroundColor:Color(0xffFFD3B2),
    body:Column(
children:[
  SizedBox(height: 10,),
  Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        IconButton(onPressed:(){Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));}, icon: Icon(Icons.arrow_circle_left_outlined,color:Colors.orange ,size: 40,)),
        SizedBox(width:60),
        Text("add tasks",style: TextStyle(color: Color(0xff29221D),fontWeight:FontWeight.w600,fontSize: 24),)




      ],),
  ),
  Container(
    width:430,height:614,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(35),color: Color(0xffFFFFFF)),

child:Padding(
  padding: const EdgeInsets.all(10.0),
  child: Column(
    children: [
      Column(
        children:[
          Row(
            children: [
              Icon(Icons.text_fields,color:Colors.black,size: 25,),
              SizedBox(width:5),
              Text("Title",style: TextStyle(color:Color(0xff29221D),fontWeight:FontWeight. w600,fontSize:15),)

            ],



          ),






        ]














      )





    ],





  ),
)





    )
    
    
    






        ]




    ),









    );
  }
}
