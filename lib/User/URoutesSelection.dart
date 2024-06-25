
// import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:project_part1/User/URidesFromFaculty.dart';
import 'package:project_part1/User/URidesToFaculty.dart';



class uRoute extends StatelessWidget {
  const uRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text("List of available trips"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 75, 12, 131),
      ),
      body: Center(
        child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('asset/img1.jpg'), width: 250, height: 250,),
              //Text("Welcome To My CarPool App" , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ),),
              //SizedBox(height: 5,),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 75, 12, 131) ),
                                    onPressed: (){Navigator.push( context,
                        MaterialPageRoute(builder: (context) => UserToFaculty()), // Navigate to second screen
                      );},  
                      child: Text("To the faculty")),
                      SizedBox(width: 40,),
                     ElevatedButton(style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 75, 12, 131) ),
                      onPressed: (){Navigator.push( context,
                        MaterialPageRoute(builder: (context) => UserFromFaculty()), // Navigate to second screen
                      );},  
                      child: Text("From the faculty")),
              
                  ],
                ),
              )

            ],
          ),
      ),
    );
  }
}



