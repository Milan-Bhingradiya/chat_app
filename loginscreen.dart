import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  String errormsg = "";
  bool errorvisible = false;
  final auth = FirebaseAuth.instance;
  bool showspinner = false;

  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("login page")),
        body: ModalProgressHUD(
          inAsyncCall: showspinner,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    margin: EdgeInsets.fromLTRB(40, 70, 30, 0),
                    width: 100,
                    height: 100,
                    child: Image.asset('images/flashchatlogo.png'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 350,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
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
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 350,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: TextField(
                          onChanged: ((value) {
                            password = value;
                          }),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter your Password",
                              fillColor: Colors.grey[400])),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Visibility(
                    visible: errorvisible, child: Text("Problem : $errormsg")),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      showspinner = true;
                    });

                    try {
                      final user = await auth.signInWithEmailAndPassword(
                          email: email, password: password);

                      if (user != null) {
                        Navigator.pushNamed(context, '/chatscreen');
                      }
                    } on FirebaseAuthException catch (e) {
                      setState(() {
                        errorvisible = true;
                        errormsg = e.message.toString();
                      });
                    } on Exception catch (f) {
                      print(f);
                    }
                    setState(() {
                      showspinner = false;
                    });
                    print(email + password);
                  },
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: 350,
                      height: 50,
                      color: Colors.blue,
                      child: Text(
                        "LOG IN",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
