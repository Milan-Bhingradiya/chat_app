import 'dart:ffi';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class registerscreen extends StatefulWidget {
  const registerscreen({super.key});

  @override
  State<registerscreen> createState() => _registerscreenState();
}

class _registerscreenState extends State<registerscreen> {
  String errormsg = "";
  bool errorvisible = false;
  late String email;
  late String password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register page")),
      body: Hero(
          tag: 'logo',
          child: SingleChildScrollView(
            child: Material(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(50, 30, 30, 0),
                    width: 230,
                    height: 230,
                    child: Image.asset('images/flashchatlogo.png'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 25, right: 25),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    alignment: Alignment.center,
                    width: 350,
                    child: TextField(
                      onChanged: ((value) {
                        email = value;
                      }),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "Enter your Email",
                        fillColor: Colors.grey[400],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 25, right: 25),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    alignment: Alignment.center,
                    width: 350,
                    child: TextField(
                        onChanged: ((value) {
                          password = value;
                        }),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            // border: InputBorder.none,
                            hintText: "Enter your Password",
                            fillColor: Colors.grey[400])),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                      visible: errorvisible,
                      child: Text("Problem : $errormsg")),
                  GestureDetector(
                      onTap: () async {
                        try {
                          final user2 =
                              await auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (user2 != null) {
                            Navigator.pushNamed(context, '/chatscreen');
                          } else {
                            print("aa");
                          }
                        } on FirebaseAuthException catch (e) {
                          setState(() {
                            errorvisible = true;
                            errormsg = e.message.toString();
                          });
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8)),
                          alignment: Alignment.center,
                          height: 50,
                          width: 350,
                          child: Text(
                            "REGISTER",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          )))
                ],
              ),
            ),
          )),
    );
  }
}
