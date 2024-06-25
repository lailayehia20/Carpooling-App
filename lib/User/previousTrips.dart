// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:project_part1/User/cart.dart';
// import 'package:project_part1/Others/homepage.dart';
// import 'package:project_part1/Payment/visaDetails.dart';

// class PrevTrips extends StatefulWidget {
//   const PrevTrips({super.key});

//   @override
//   State<PrevTrips> createState() => _PrevTripsState();
// }

// class _PrevTripsState extends State<PrevTrips> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Cart"),
//         centerTitle: true,
//         backgroundColor: Color.fromARGB(255, 75, 12, 131),
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//         child: 
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//              SizedBox(height: 10,),
             
              
//               Container(
//                 width: 280,
//                 height: 180,
//                  decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.black,
//                       width: 2,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                        Text("Route choosen:", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                        Text('Abbasseya Square - Gate 3', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                        Text("Date entered:", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                        Text('1/11/2023', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                        Text("Time Selected:", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                        Text('10:30 am', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                        Text("Trip Price:", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                        Text('50 LE', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                       
//                     ],
//                   ),
//                 ),),
//             SizedBox(height: 10,),
//             Container(
//                 width: 280,
//                 height: 180,
//                  decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.black,
//                       width: 2,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                        Text("Route choosen:", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                        Text('Gate 3 - Abdu Basha', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                        Text("Date entered:", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                        Text('5/11/2023', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                        Text("Time Selected:", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                        Text('1:30 pm', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                        Text("Trip Price:", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                        Text('30 LE', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                       
//                     ],
//                   ),
//                 ),),
//                  SizedBox(height: 10,),
//             Container(
//                 width: 280,
//                 height: 180,
//                  decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.black,
//                       width: 2,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                        Text("Route choosen:", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                        Text('Gate 4 - Abbasseya Square', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                        Text("Date entered:", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                        Text('9/11/2023', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                        Text("Time Selected:", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                        Text('3:30 pm', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                        Text("Trip Price:", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                        Text('45 LE', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                       
//                     ],
//                   ),
//                 ),),
//                  //SizedBox(height: 10,),
                 

//             ],
//           ),
//       ),
//       ),
//       drawer: Drawer(
//         child: Container(
//           height: double.infinity,
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               Row(
//                 children: [
//                   IconButton(
//                       icon: Icon(Icons.arrow_back),
//                       onPressed: () {
//                         Navigator.pop(context);
//                         Navigator.pop(context);
//           },
//         ),
//         Text("Go to the previous page",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                 ],
//               ),
//               // ListTile(
//               //   title: const Text('Available Routes', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//               //   onTap: () {
//               //     Navigator.push(
//               //       context,
//               //       MaterialPageRoute(builder: (context) => Request()), // Navigate to second screen
//               //     );
//               //   },
//               // ),
//               ListTile(
//                 title: const Text('Cart', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => Cart()), // Navigate to second screen
//                   );
//                 },
//               ),
//               ListTile(
//                 title: const Text('Order History', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => PrevTrips()), // Navigate to second screen
//                   );
//                 },
//               ),
//               ListTile(
//                 title: const Text('Credit Card Details', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => PaymentDetails()), // Navigate to second screen
//                   );
//                 },
//               ),
//               ListTile(
//                 title: const Text('Logout', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                 onTap: () {
//                   print("Signed out");
//                   FirebaseAuth.instance.signOut().then((value){
//                     Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => HomePage()), // Navigate to second screen
//                   );
//                   });
                  
//                 },
//               ),
               
//             ],
//           ),
//         ),
//       ),
      
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class PrevTrips extends StatefulWidget {
  const PrevTrips({Key? key}) : super(key: key);

  @override
  _PrevTripsState createState() => _PrevTripsState();
}

class _PrevTripsState extends State<PrevTrips> {
  String? userId = FirebaseAuth.instance.currentUser!.uid;

  Future<List<Map<String, dynamic>>> getUserRequests() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Requests')
        .where('userId', isEqualTo: userId)
        .get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> requests = querySnapshot.docs;

    List<Map<String, dynamic>> userRequests = [];
    userRequests.addAll(requests.map((request) => request.data()));

    return userRequests;
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Order History"),
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 75, 12, 131),
    ),
    body: FutureBuilder<List<Map<String, dynamic>>>(
      future: getUserRequests(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Map<String, dynamic>> userRequests = snapshot.data ?? [];
          userRequests = userRequests.where((request) => request['status'] == 'Accepted').toList();

          if (userRequests.isNotEmpty) {
            return ListView(
              padding: EdgeInsets.all(16.0),
              children: userRequests.map((request) {
                return Card(
                  elevation: 3.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('From: ${request['pickup']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        Text('Destination: ${request['destination']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        Text('Price: ${request['price']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        Text('Checkpoint: ${request['pickup_checkpoint']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        Text('Date: ${request['date']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        Text('Time: ${request['time']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          } else {
            return Center(child: Text('No accepted requests available'));
          }
        }
      },
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

