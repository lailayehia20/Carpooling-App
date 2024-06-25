

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_part1/Payment/visaDetails.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
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
        title: Text("Your Requests"),
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
                          Text('Status: ${request['status']}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                          ElevatedButton(
                            onPressed: () {
                              if (request['status'] == 'Pending') {
                                _showSnackBar('Please wait for the driver confirmation.');
                              } else if (request['status'] == 'Accepted') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PaymentDetails()),
                                );
                              } else if (request['status'] == 'Rejected') {
                                _showSnackBar('The ride has been cancelled by the driver.');
                              }
                            },
                            style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 75, 12, 131)),
                            child: Text('Proceed to payment'),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            } else {
              return Center(child: Text('No requests available'));
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

