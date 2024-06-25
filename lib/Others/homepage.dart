import 'package:flutter/material.dart';
import 'package:project_part1/Others/signin.dart';
import 'package:project_part1/Others/signup.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('asset/img1.jpg'), width: 250, height: 250,),
              Text("Welcome To My CarPool App" , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ),),
              SizedBox(height: 5,),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 75, 12, 131) ),
                                    onPressed: (){Navigator.push( context,
                        MaterialPageRoute(builder: (context) => SignIn()), // Navigate to second screen
                      );},  
                      child: Text("Sign in")),
                      SizedBox(width: 40,),
                     ElevatedButton(style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 75, 12, 131) ),
                      onPressed: (){Navigator.push( context,
                        MaterialPageRoute(builder: (context) => SignUp()), // Navigate to second screen
                      );},  
                      child: Text("Sign up")),
              
                  ],
                ),
              )

            ],
          ),
      ),
    );
  }
}



