

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:project_part1/User/user_model.dart';

// class DriverRequestsScreen extends StatefulWidget {
//   const DriverRequestsScreen({Key? key}) : super(key: key);

//   @override
//   _DriverRequestsScreenState createState() => _DriverRequestsScreenState();
// }

// class _DriverRequestsScreenState extends State<DriverRequestsScreen> {
//   String? driverId = FirebaseAuth.instance.currentUser!.uid;

//   Future<UserModel?> _fetchUserData(String userId) async {
//     try {
//       DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
//           .collection('Users')
//           .doc(userId)
//           .get();

//       return UserModel(
//         name: userSnapshot['Name'],
//         phone: userSnapshot['Phone'],
//         email: userSnapshot['Email'],
//         password: userSnapshot['Password'],
//       );
//     } catch (e) {
//       print('Error fetching user data: $e');
//       return null;
//     }
//   }

//   Future<List<Map<String, dynamic>>> getDriverRequests() async {
//     QuerySnapshot<Map<String, dynamic>> querySnapshot =
//         await FirebaseFirestore.instance.collection('Users').get();

//     List<QueryDocumentSnapshot<Map<String, dynamic>>> drivers = querySnapshot.docs;

//     List<Map<String, dynamic>> allRides = [];

//     for (QueryDocumentSnapshot<Map<String, dynamic>> driver in drivers) {
//       QuerySnapshot<Map<String, dynamic>> ridesSnapshot = await driver.reference
//           .collection('Requests')
//           .where('driverId', isEqualTo: driverId)
//           .get();

//       List<QueryDocumentSnapshot<Map<String, dynamic>>> rides = ridesSnapshot.docs;

//       // Add rides data to the list
//       allRides.addAll(rides.map((ride) => ride.data()));
//     }

//     return allRides;
//   }

//   Future<void> acceptRideRequest(String rideId,Map<String, dynamic> request) async {
//                     try {
//                       // Update the status to 'confirmed' in the user's Requested Rides
//                       await FirebaseFirestore.instance
//                           .collection('Users/${request['userId']}/Requests')
//                           .doc(rideId)
//                           .update({'status': 'confirmed'});

//                       // You may want to perform additional actions here

//                       print('Ride request accepted successfully');
//                     } catch (error) {
//                       print('Error accepting ride request: $error');
//                     }
//                   }

// Future<void> rejectRideRequest(String rideId,Map<String, dynamic> request) async {
//   try {
//     // Update the status to 'rejected' in the user's Requested Rides
//     await FirebaseFirestore.instance
//         .collection('Users/${request['userId']}/Requests')
//         .doc(rideId)
//         .update({'status': 'rejected'});

//     // You may want to perform additional actions here

//     print('Ride request rejected successfully');
//   } catch (error) {
//     print('Error rejecting ride request: $error');
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Driver Requests"),
//         centerTitle: true,
//         backgroundColor: Color.fromARGB(255, 75, 12, 131),
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: getDriverRequests(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             List<Map<String, dynamic>> driverRequests = snapshot.data ?? [];
//             if (driverRequests.isNotEmpty) {
//               return ListView(
//                 padding: EdgeInsets.all(16.0),
//                 children: driverRequests.map((request) {
//                   return FutureBuilder<UserModel?>(
//                     future: _fetchUserData(request['userId']),
//                     builder: (context, userSnapshot) {
//                       if (userSnapshot.connectionState == ConnectionState.waiting) {
//                         return CircularProgressIndicator();
//                       } else if (userSnapshot.hasError) {
//                         return Text('Error: ${userSnapshot.error}');
//                       } else {
//                         UserModel? userData = userSnapshot.data;
//                         return Card(
//                           elevation: 3.0,
//                           margin: EdgeInsets.symmetric(vertical: 8.0),
//                           child: Padding(
//                             padding: EdgeInsets.all(16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('User Name: ${userData?.name}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//                                 Text('User Phone: ${userData?.phone}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//                                 Text('From: ${request['destination']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//                                 Text('Destination: ${request['pickup']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//                                 Text('Price: ${request['price']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//                                 Text('Checkpoint: ${request['pickup_checkpoint']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//                                 Text('Date: ${request['date']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//                                 Text('Time: ${request['time']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//                                 SizedBox(height: 10),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                   children: [
//                                     ElevatedButton(
//                                       style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 75, 12, 131)),
//                                       onPressed: () {
//                                         acceptRideRequest(request['rideId'],request);
//                                       },
//                                       child: Text("Accept"),
//                                     ),
//                                     ElevatedButton(
//                                       style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 75, 12, 131)),
//                                       onPressed: () {
//                                         rejectRideRequest(request['rideId'],request);
//                                       },
//                                       child: Text("Reject"),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }
//                     },
//                   );
//                 }).toList(),
//               );
//             } else {
//               return Center(child: Text('No requests available'));
//             }
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_part1/Others/homepage.dart';
import 'package:project_part1/Others/profile.dart';
import 'package:project_part1/User/user_model.dart';

class DriverRequestsScreen extends StatefulWidget {
  const DriverRequestsScreen({Key? key}) : super(key: key);

  @override
  _DriverRequestsScreenState createState() => _DriverRequestsScreenState();
}

class _DriverRequestsScreenState extends State<DriverRequestsScreen> {
  String? driverId = FirebaseAuth.instance.currentUser!.uid;

  Future<UserModel?> _fetchUserData(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();

      return UserModel(
        name: userSnapshot['Name'],
        phone: userSnapshot['Phone'],
        email: userSnapshot['Email'],
        password: userSnapshot['Password'],
      );
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getDriverRequests() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('Users').get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> drivers = querySnapshot.docs;

    List<Map<String, dynamic>> allRides = [];

    for (QueryDocumentSnapshot<Map<String, dynamic>> driver in drivers) {
      QuerySnapshot<Map<String, dynamic>> ridesSnapshot = await driver.reference
          .collection('Requests')
          .where('driverId', isEqualTo: driverId)
          .get();

      List<QueryDocumentSnapshot<Map<String, dynamic>>> rides = ridesSnapshot.docs;

      // Add rides data to the list
      allRides.addAll(rides.map((ride) => ride.data()));
    }

    return allRides;
  }

  Future<void> acceptRideRequest(String rideId, Map<String, dynamic> request) async {
  try {
    // Query to get all documents in the 'Requested Rides' collection with the specified rideId
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('Users/${request['userId']}/Requests')
        .where('rideId', isEqualTo: rideId)
        .get();

    // Update each document with the specified rideId to set the status to 'confirmed'
    for (QueryDocumentSnapshot<Map<String, dynamic>> document in querySnapshot.docs) {
      await document.reference.update({'status': 'Accepted'});
    }

    // You may want to perform additional actions here

    print('Ride requests accepted successfully');
  } catch (error) {
    print('Error accepting ride requests: $error');
  }
}

  Future<void> rejectRideRequest(String rideId, Map<String, dynamic> request) async {
    try {
      // Query to get all documents in the 'Requested Rides' collection with the specified rideId
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('Users/${request['userId']}/Requests')
          .where('rideId', isEqualTo: rideId)
          .get();

      // Update each document with the specified rideId to set the status to 'confirmed'
      for (QueryDocumentSnapshot<Map<String, dynamic>> document in querySnapshot.docs) {
        await document.reference.update({'status': 'Rejected'});
      }
      print('Ride requests is rejected ');

    } catch (error) {
      print('Error rejecting ride request: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Requests"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 75, 12, 131),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getDriverRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> driverRequests = snapshot.data ?? [];
            if (driverRequests.isNotEmpty) {
              return ListView(
                padding: EdgeInsets.all(16.0),
                children: driverRequests.map((request) {
                  return FutureBuilder<UserModel?>(
                    future: _fetchUserData(request['userId']),
                    builder: (context, userSnapshot) {
                      if (userSnapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (userSnapshot.hasError) {
                        return Text('Error: ${userSnapshot.error}');
                      } else {
                        UserModel? userData = userSnapshot.data;
                        return Card(
                          elevation: 3.0,
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text('User Name: ${userData?.name}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                Text('User Phone: ${userData?.phone}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                Text('From: ${request['destination']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                Text('Destination: ${request['pickup']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                Text('Price: ${request['price']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                Text('Checkpoint: ${request['pickup_checkpoint']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                Text('Date: ${request['date']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                Text('Time: ${request['time']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 75, 12, 131)),
                                      onPressed: () {
                                        acceptRideRequest(request['rideId'], request);
                                      },
                                      child: Text("Accept"),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 75, 12, 131)),
                                      onPressed: () {
                                        rejectRideRequest(request['rideId'], request);
                                      },
                                      child: Text("Reject"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  );
                }).toList(),
              );
            } else {
              return Center(child: Text('No requests available'));
            }
          }
        },
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

