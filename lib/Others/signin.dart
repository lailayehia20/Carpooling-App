

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_part1/Driver/dRouteSelection.dart';
import 'package:project_part1/Driver/driver_controller.dart';
import 'package:project_part1/User/URoutesSelection.dart';
import 'package:project_part1/User/user_controller.dart';

class SignIn extends StatefulWidget {
 const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool beDriver = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in" ,style: TextStyle(color: Colors.white),),
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
                  style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 75, 12, 131)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String email = emailController.text.trim();
                      String password = _passwordController.text.trim();

                      if (beDriver) {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: '$email.driver', password: password)
                            .then((value) async {
                          Navigator.push( context,
                        //MaterialPageRoute(builder: (context) =>  const DriverFromFaculty()), // Navigate to second screen
                        MaterialPageRoute(builder: (context) =>  const dRoute()), 
                      );
                          String? uid = await DriverController.getDriverUID();
                          DriverController().getDriverData(uid!);

                          check();
                        }).onError((error, stackTrace) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                'You entered wrong data',
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
                        });
                      } else {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: _passwordController.text)
                            .then((value) async {
                          Navigator.push( context,
                        MaterialPageRoute(builder: (context) => uRoute() ), // Navigate to second screen
                      );
                          String? uid = await UserController.getUserUID();
                          UserController().getUserData(uid!);
                          check();
                        }).onError((error, stackTrace) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                'You entered wrong data',
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
                        });
                      }
                    }
                  },
                  child: const Text("Submit", style: TextStyle(color: Colors.white),),
                )
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
