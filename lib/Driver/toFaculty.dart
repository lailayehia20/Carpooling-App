import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_part1/Driver/driver_requets.dart';
import 'package:project_part1/Others/homepage.dart';
import 'package:project_part1/Others/profile.dart';
import 'package:intl/intl.dart';



const List<String> gates = <String>['Gate 3', 'Gate 4'];
String? dropdownValue ="Time";
String? dropdownValue2 ="Gate";

class DriverToFaculty extends StatefulWidget {
  const DriverToFaculty({Key? key, }) : super(key: key);

  @override
  State<DriverToFaculty> createState() => _DriverToFacultyState();
}

class _DriverToFacultyState extends State<DriverToFaculty> {


  final TextEditingController fromController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController checkpointController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  Future<void> saveRideDetailsToFirestore() async {
  String userId = FirebaseAuth.instance.currentUser!.uid;

  DocumentReference rideReference= await FirebaseFirestore.instance.collection('Drivers').doc(userId).collection('RidesToFaculty').add({
    'pickup': fromController.text,
    'destination': dropdownValue2,
    'price': priceController.text,
    'pickup_checkpoint': checkpointController.text,
    'date': dateController.text,
    'time': dropdownValue,
    'driverId':userId,

  });
      String rideId = rideReference.id;
      await rideReference.update({'rideId': rideId});
}






 DateTime? selectedTime;
 DateTime? selectedDate;

Future<void> _selectDate(BuildContext context) async {
  DateTime currentDate = DateTime.now();
  DateTime? picked = await showDatePicker(
    context: context,
    initialDate: currentDate,
    firstDate: currentDate, // Allow the current date to be selected
    lastDate: DateTime(2101),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: Color.fromARGB(255, 75, 12, 131),
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          colorScheme: ColorScheme.light(primary: Color.fromARGB(255, 75, 12, 131)).copyWith(secondary: Color.fromARGB(255, 75, 12, 131)),
        ),
        child: child!,
      );
    },
  );

  if (picked != null) {
    setState(() {
      selectedDate = picked;
      dateController.text = DateFormat('MM/dd/yyyy').format(selectedDate!);
    });
  }
}

Future<void> _selectTime(BuildContext context) async {
  TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: Color.fromARGB(255, 75, 12, 131),
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          colorScheme: ColorScheme.light(primary: Color.fromARGB(255, 75, 12, 131)).copyWith(secondary: Color.fromARGB(255, 75, 12, 131)),
        ),
        child: child!,
      );
    },
  );

  if (picked != null && _isTimeWithinBounds(picked)) {
    setState(() {
      selectedTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        picked.hour,
        picked.minute,
      );

      dropdownValue = DateFormat('hh:mm a').format(selectedTime!);
    });
  }
}

bool _isTimeWithinBounds(TimeOfDay time) {
  final int lowerBoundHour = 7;
  final int lowerBoundMinute = 30;

  int selectedHour = time.hour;
  int selectedMinute = time.minute;





  return (selectedHour == lowerBoundHour && selectedMinute == lowerBoundMinute) ;

}



@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Trip Details"),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 75, 12, 131),
    ),
    body: SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage('asset/img1.jpg'), width: 200, height: 200,),
            Text("Heading To Faculty", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Pickup area:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(width: 15),
                      Expanded(
                         child: TextField(
                            controller: fromController,
                            decoration: const InputDecoration(
                              hintText: 'e.g. Nasr City',
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2.0)),
                            ),
                          ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Destination:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(width: 15),
                      Expanded(
                         child: DropdownMenu<String>(
                            initialSelection: gates.first,
                            onSelected: (String? value) {
                              setState(() {
                                dropdownValue2 = value!;
                              });
                            },
                            dropdownMenuEntries: gates.map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(value: value, label: value);
                            }).toList(),
                          ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: checkpointController,
                    decoration: InputDecoration(
                      hintText: 'Enter exact pickup location',
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2.0)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: priceController,
                    decoration: const InputDecoration(
                      hintText: 'Enter the Trip price ex: 50 LE',
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2.0)),
                    ),
                  ),                  
                  const SizedBox(height: 10),
                  TextField(
                    controller: dateController,
                    onTap: () => _selectDate(context),
                    decoration: InputDecoration(
                      hintText: 'Select date',
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2.0)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Select time:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () => _selectTime(context),
                        child: Container(
                          width: 150,
                          child: InputDecorator(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2.0)),
                            ),
                            child: Text(
                              selectedTime != null ? DateFormat('hh:mm a').format(selectedTime!) : 'Select Time',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 75, 12, 131)),
                    onPressed: () {
                      saveRideDetailsToFirestore();
                    },
                    child: const Text("Make Offer"),
                  ),
                ],
              ),
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

