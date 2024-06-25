
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_part1/Driver/driver_requets.dart';
import 'package:project_part1/Driver/fromFaculty.dart';
import 'package:project_part1/Driver/toFaculty.dart';
import 'package:project_part1/Others/homepage.dart';
import 'package:project_part1/Others/profile.dart';


class dRoute extends StatelessWidget {
  const dRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 75, 12, 131),
      ),
      body: Center(
        child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('asset/img1.jpg'), width: 250, height: 250,),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 75, 12, 131) ),
                                    onPressed: (){Navigator.push( context,
                        MaterialPageRoute(builder: (context) => DriverToFaculty()), // Navigate to second screen
                      );},  
                      child: Text("To the faculty")),
                      SizedBox(width: 40,),
                     ElevatedButton(style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 75, 12, 131) ),
                      onPressed: (){Navigator.push( context,
                        MaterialPageRoute(builder: (context) => DriverFromFaculty()), // Navigate to second screen
                      );},  
                      child: Text("From the faculty")),
              
                  ],
                ),
              )

            ],
          ),
      ),
      drawer: Drawer(
      child: Container(
        height: double.infinity,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
                const Text("Go to the previous page", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              ],
            ),
            ListTile(
              title: const Text('Profile', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profile(isDriver: true,)),
                );
              },
            ),
            ListTile(
              title: const Text('Driver request', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              onTap: () {
                print("Driver request");
                // FirebaseAuth.instance.signOut().then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DriverRequestsScreen()),
                  );
                // }
                // );
              },
            ),
            ListTile(
              title: const Text('Logout', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              onTap: () {
                print("Signed out");
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                });
              },
            ),
            
          ],
        ),
      ),
    ),
    );
  }
}



