
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_part1/Others/profile.dart';
import 'package:project_part1/User/cart.dart';
import 'package:project_part1/Others/homepage.dart';
import 'package:project_part1/User/previousTrips.dart';
import 'package:project_part1/User/ridesdb.dart';




class UserFromFaculty extends StatefulWidget {
  UserFromFaculty({Key? key}) : super(key: key);

  @override
  State<UserFromFaculty> createState() => _UserFromFacultyState();
}

class _UserFromFacultyState extends State<UserFromFaculty> {

  List<String> requestedRideIds = [];
  bool enableTimeCredentialCheck = true;


  Future<List<Map<String, dynamic>>> retrieveRideDetails() async {
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
      .collection('Drivers')
      .get();

  List<QueryDocumentSnapshot<Map<String, dynamic>>> drivers = querySnapshot.docs;

  List<Map<String, dynamic>> allRides = [];

  for (QueryDocumentSnapshot<Map<String, dynamic>> driver in drivers) {
    QuerySnapshot<Map<String, dynamic>> ridesSnapshot = await driver.reference
        .collection('RidesFromFaculty')
        .get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> rides = ridesSnapshot.docs;

    // Add rides data to the list
    allRides.addAll(rides.map((ride) => ride.data()));
  }

  return allRides;
}

Future<void> saveRideDetailsToFirestore(Ride ride) async {
  if (requestedRideIds.contains(ride.rideId)) {
        _showSnackBar('You have already requested this ride');
        return; 
      }
      requestedRideIds.add(ride.rideId);
  String userId = FirebaseAuth.instance.currentUser!.uid;

  await FirebaseFirestore.instance.collection('Users').doc(userId).collection('Requests').add({
    'pickup': ride.pickup,
    'destination': ride.destination,
    'price': ride.fare,
    'pickup_checkpoint': ride.meetingPoint,
    'date': ride.date,
    'time': ride.time,
    'driverId':ride.driverId,
    'rideId':ride.rideId,
    'userId':userId,
    'status':"Pending",
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of available trips"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 75, 12, 131),
      ),

      body: SingleChildScrollView(
  child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image: AssetImage('asset/img1.jpg'), width: 200, height: 200),
        FutureBuilder<List<Map<String, dynamic>>>(
          future: retrieveRideDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Map<String, dynamic>> rideDetails = snapshot.data ?? [];
              if (rideDetails.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: rideDetails.map((data) {

                    try {
                            DateTime rideDateTime = DateFormat('MM/dd/yyyy hh:mm a').parse('${data['date']} ${data['time']}');
                            DateTime deadline = DateTime(
                              rideDateTime.year,
                              rideDateTime.month,
                              rideDateTime.day , 
                              13, 
                            );

                            if (DateTime.now().isAfter(deadline) && enableTimeCredentialCheck) {
                              return Container(); 
                            }
                          } catch (e) {
                            print('Error parsing date or time: $e');
                            print('Date: ${data['date']}');
                            print('Time: ${data['time']}');
                            return Container(); 
                          } 


                    return Card(
                      elevation: 3.0,
                      margin: EdgeInsets.all(16.0),
                      child: Container(
                        width: 300,
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('From: ${data['pickup']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            Text('Destination: ${data['destination']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            Text('Price: ${data['price']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            Text('Exact Checkpoint: ${data['destination_checkpoint']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            Text('Date: ${data['date']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            Text('Time: ${data['time']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 75, 12, 131)),
                              onPressed: () async{
                                Ride ride = Ride(
                                  pickup: data['pickup'],
                                  destination: data['destination'],
                                  fare: data['price'],
                                  meetingPoint: data['destination_checkpoint'],
                                  date: data['date'],
                                  time: data['time'],
                                  driverId: data['driverId'],
                                  rideId: data['rideId'],
                                );
                                await saveRideDetailsToFirestore(ride);
                                      Navigator.push( context,
                                MaterialPageRoute(builder: (context) => Cart() ), // Navigate to second screen
                              );
                              },
                              child: Text("Make Request"),
                            ),
                            
                          ],  
                        ),
                      ),
                    );
                  }).toList(),
                );
              } else {
                return Text('No rides available');
              }
            }
          },
        ),
      Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: enableTimeCredentialCheck,
                    onChanged: (value) {
                      setState(() {
                        enableTimeCredentialCheck = value!;
                      });
                    },
                    activeColor: const Color.fromARGB(255, 75, 12, 131),
                  ),
                  Text("Enable Time Credential Check"),
                ],
              ),
            ],
          ),
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
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                  Text("Go to the previous page", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                ],
              ),
              ListTile(
                title: const Text('Cart', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cart()),
                  );
                },
              ),
              ListTile(
                title: const Text('Order History', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PrevTrips()),
                  );
                },
              ),
              ListTile(
                title: const Text('Profile', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Profile(isDriver: false,)),
                  );
                },
              ),
              ListTile(
                title: const Text('Logout', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                onTap: () {
                  print("Signed out");
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
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
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.deepPurple[100],
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}


