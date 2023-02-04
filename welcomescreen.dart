//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class welcomescreen extends StatefulWidget {
  const welcomescreen({super.key});

  @override
  State<welcomescreen> createState() => _welcomescreenState();
}

class _welcomescreenState extends State<welcomescreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.bounceOut);
    controller.forward();

    animation.addStatusListener((status) {
      if (AnimationStatus.completed == status) {
        controller.reverse();
      } else if (AnimationStatus.dismissed == status) {
        controller.forward();
      }
      print(status);
    });

    controller.addListener(
      () {
        setState(() {});
        print(animation.value);
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                  tag: 'logo',
                  child: Container(
                    height: 150,
                    child: Container(
                      width: animation.value * 150,
                      height: animation.value * 200,
                      child: Image.asset(
                        'images/flashchatlogo.png',
                      ),
                    ),
                  )),
              Container(
                alignment: Alignment.center,
                height: 80,
                child: Text(
                  "Flash Chat App",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                ),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/loginscreen');
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.blue[400],
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
              height: 45,
              width: 400,
              child: Text(
                "Login",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: (() {
              Navigator.pushNamed(context, '/Registerscreen');
            }),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.blue[400],
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
              height: 45,
              width: 400,
              child: Text(
                "Register",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
