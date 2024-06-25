

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_part1/Payment/visamodel.dart';


class PaymentDetails extends StatefulWidget {
  const PaymentDetails({Key? key, 
  }) : super(key: key);

  @override
  _PaymentDetailsState createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  String _selectedPaymentMethod = '';
  bool _creditCardDetailsSaved = false;

  TextEditingController cardNoController = TextEditingController();
  TextEditingController DateOfExpiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();


  @override
  void initState() {
    super.initState();
    // Fetch credit card details when the page loads
    _fetchCreditCardDetails();
  }

  Future<void> _fetchCreditCardDetails() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('CreditCardDetails')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there is only one document for the user
        DocumentSnapshot<Map<String, dynamic>> docSnapshot =
            querySnapshot.docs.first;

        // Credit card details exist for the user, fetch and display them
        visaDet creditCardDetails =
        visaDet.fromMap(docSnapshot.data()!);
        _selectedPaymentMethod = 'CreditCardDetails';

        // Set the text in the controllers with the fetched data
        cardNoController.text = creditCardDetails.cardNumber;
        DateOfExpiryController.text = creditCardDetails.expirationDate;
        cvvController.text = creditCardDetails.cvv;

        print("Credit Card details are saved");
        _creditCardDetailsSaved = true; // Set to true if details exist
      }
    } catch (e) {
      print('Error fetching credit card details: $e');
    }
  }



    Future<void> _saveCreditCardDetails() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    try {
      // Save credit card details to Firestore
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('CreditCardDetails')
          .add({
        'cardNumber': cardNoController.text,
        'expirationDate': DateOfExpiryController.text,
        'cvv': cvvController.text,
      });
    _showSnackBar('Credit card details are successfully saved');
    _creditCardDetailsSaved = true; // Set to true after saving details
  } catch (e) {
    print('Error saving credit card details: $e');
    _showSnackBar('An error occurred while saving the credit card details. Try again!');
  }
}

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
       appBar: AppBar(
        title: const Text("Credit Card Details"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 75, 12, 131),
      ),
      //backgroundColor: Colors.white,
      body: SingleChildScrollView(child: 
       Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: Image(image: AssetImage('asset/img1.jpg'), width: 200, height: 200,),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedPaymentMethod = 'Cash';
                });
                _showSnackBar('Cash payment is selected successfully!');
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 75, 12, 131)),
              
              child: const Text(
                'Pay with Cash',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedPaymentMethod = 'Credit Card';
                });
                _showSnackBar('Credit card payment is selected successfully!');
              },
             style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 75, 12, 131)),
              child: const Text(
                'Pay with Credit Card',
                style: TextStyle(fontSize: 18),
              ),
            ),
            if (_selectedPaymentMethod == 'Credit Card' && !_creditCardDetailsSaved  ) ...[
              const SizedBox(height: 30.0),
             
             
          Container(
              width: 300,
              height: 80,
              child: 
                  TextField(
                    controller: cvvController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                    hintText: 'CVV',
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2.0)),
                  ),
                  ),
          ),
              const SizedBox(height: 16.0),
              Container(
              width: 300,
              height: 80,
              child: 
                TextField(
                  controller: DateOfExpiryController,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                    hintText: 'Expiration Date (MM/YY)',
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2.0)),
                  ),
                ),
          ),
              const SizedBox(height: 16.0),
               Container(
              width: 300,
              height: 80,
              child: 
                TextField(
                  controller: cardNoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Card Number',
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2.0)),
                  ),
                ),
            ),
             const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_selectedPaymentMethod.isNotEmpty) {
                   //_showSnackBar('Payment method selected: ');
                   if (_selectedPaymentMethod == 'Credit Card') {
                    // Check if credit card details are already saved
                    if (!_creditCardDetailsSaved) {
                      // Save credit card details only if not already saved
                      _saveCreditCardDetails();
                    } else {
                      // Show a message indicating that details are already saved
                      _showSnackBar('Credit card details already saved!');
                    }
                  }
                  } else {
                    // Handle other payment methods or show an error message
                    _showSnackBar('Please choose a payment method.');
                  }

              },
             style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 75, 12, 131)),
              child: const Text(
                'Save Payment Method',
                style: TextStyle(fontSize: 18),
              ),
            ),
            ],
           
          ],
        ),
      ),) 
     
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



