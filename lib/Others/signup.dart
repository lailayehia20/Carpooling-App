
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_part1/Driver/dRouteSelection.dart';
import 'package:project_part1/Driver/driver_controller.dart';
import 'package:project_part1/Driver/driver_model.dart';
import 'package:project_part1/Others/sqlite_db.dart';
import 'package:project_part1/User/URoutesSelection.dart';
import 'package:project_part1/User/user_controller.dart';
import 'package:project_part1/User/user_model.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool beDriver = false;

  final _formKey = GlobalKey<FormState>();
    mydatabaseclass mydb = mydatabaseclass();
  List<Map> mylist = [];

  Future Reading_Database() async {
    List<Map> response = await mydb.reading('''SELECT * FROM 'TABLE1' ''');
    mylist = [];
    mylist.addAll(response);
    setState(() {});
  }

  @override
  void initState() {
    Reading_Database();
    super.initState();
    mydb.checking();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 75, 12, 131),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(image: AssetImage('asset/img1.jpg'), width: 200, height: 200,),
                const SizedBox(height: 10),
                SizedBox(
                  width: 300,
                  height: 80,
                  child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2.0)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 80,
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2.0)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 80,
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2.0)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 80,
                  child: TextFormField(
                    controller: mobileController,
                    decoration: const InputDecoration(
                      hintText: 'Mobile Phone',
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2.0)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: beDriver,
                      onChanged: (value) {
                        setState(() {
                          beDriver = value!;
                        });
                      },
                      activeColor: const Color.fromARGB(255, 75, 12, 131),
                    ),
                    const Text('Driver'),
                    const SizedBox(width: 20),
                    Checkbox(
                      value: !beDriver,
                      onChanged: (value) {
                        setState(() {
                          beDriver = !value!;
                        });
                      },
                      activeColor: const Color.fromARGB(255, 75, 12, 131),
                    ),
                    const Text('User'),
                  ],
                ),

                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String email = emailController.text.trim();
                      String password = _passwordController.text.trim();

                      if (email.endsWith('@eng.asu.edu.eg')) {
                          if (beDriver) {
                
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: '$email.driver', password: password)
                              .then((value) async {
                           
                           Navigator.push( context,
                        MaterialPageRoute(builder: (context) =>  dRoute()), 
                      );
                            
                            String? uid = await DriverController.getDriverUID();

                            
                            Driver driver = Driver(
                              id: uid,
                              name: nameController.text,
                              email: email,
                              phone: mobileController.text,
                              password: password,
                            );

                            await DriverController().addDriverData(driver);
                            DriverController().getDriverData(uid!);
                            check();

                            
                          }).catchError(
                            (error) {

                              print('Error: $error');
                            },
                          );
                        await mydb.writing({
                          'name': nameController.text,
                          'mobile': mobileController.text,
                          'password': password,
                          'email': emailController.text,
                        });
                        Reading_Database();
                        setState(() {});
                          // await DatabaseHelper.instance.insertUser({
                          //     //'id': uid,
                          //     'name': nameController.text,
                          //     'mobile': mobileController.text,
                          //     'email': emailController.text,
                          //     'password': _passwordController.text,
                          //   });
                           
                        } else {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email, password: password)
                              .then((value) async {
                            Navigator.push( context,
                        MaterialPageRoute(builder: (context) => uRoute() ), 
                      );
                            String? uid = await UserController.getUserUID();

                            // Create a UserModel instance
                            UserModel user = UserModel(
                              id: uid,
                              name: nameController.text,
                              email: email,
                              phone: mobileController.text,
                              password: password,
                            );

                            
                            await UserController().addUserData(user);
                            UserController().getUserData(uid!);
                            check();
                            
                          }).catchError(
                            (error) {
                              
                              print('Error: $error');
                            },
                          );
                           await mydb.writing({
                          'name': nameController.text,
                          'mobile': mobileController.text,
                          'password': password,
                          'email': emailController.text,
                        });
                        Reading_Database();
                        setState(() {});
                           
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              'Please enter the email in the following format @eng.asu.edu.eg',
                              style: TextStyle(color: Colors.black),
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
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 75, 12, 131)),
                  child: const Text("Sign Up"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  check() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Account is successfully created!!',
          style: TextStyle(color: Colors.black),
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

