import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_part1/Driver/driver_model.dart';
import 'package:project_part1/Others/homepage.dart';
import 'package:project_part1/User/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Profile extends StatefulWidget {
  final bool isDriver;
  const Profile({Key? key, required this.isDriver}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  UserModel? user;
  Driver? driver;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      // Get the current user
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection(widget.isDriver? 'Drivers' : 'Users')
            .doc(currentUser.uid)
            .get();

        if (widget.isDriver){
          setState(() {
            driver = Driver(
              name: userSnapshot['Name'],
              phone: userSnapshot['Phone'],
              email: userSnapshot['Email'],
              password: userSnapshot['Password'],
              // Password is not retrieved for security reasons
            );
          });
        }
        // Extract data from the snapshot and update the UI
        else {
          setState(() {
            user = UserModel(
              name: userSnapshot['Name'],
              phone: userSnapshot['Phone'],
              email: userSnapshot['Email'],
              password: userSnapshot['Password'],
            );
          });
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 75, 12, 131),
      ),
      body: Center(
        child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage('asset/img1.jpg'), width: 250, height: 250,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Name: ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                  Text(" ${widget.isDriver? driver?.name : user?.name}", style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Email: ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                  Text("${widget.isDriver? driver?.email : user?.email}", style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Phone Number: ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                  Text("${widget.isDriver? driver?.phone : user?.phone}", style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),),
                ],
              ),
              ElevatedButton(
              onPressed: (){
                    FirebaseAuth.instance.signOut().then((value){
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()), // Navigate to second screen
                  );
                  }
                  );
              },
             style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 75, 12, 131)),
              child: const Text(
                'Logout',
                style: TextStyle(fontSize: 18),
              ),
            ),
 

            ]
          )
      )
      
      );
  }
}

