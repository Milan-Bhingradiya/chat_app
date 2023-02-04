import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;

class chatscreen extends StatefulWidget {
  const chatscreen({super.key});

  @override
  State<chatscreen> createState() => _chatscreenState();
}

class _chatscreenState extends State<chatscreen> {
  final user = FirebaseAuth.instance.currentUser?.email;
  final msgtextcontoller = TextEditingController();

  late String meassagetext;

  final firestore = FirebaseFirestore.instance;

//   void getmsg() async {
// // using .get methd
//     //final allmsg =await FirebaseFirestore.instance.collection('msgdata').get();
//     // for (final a in allmsg.docs) {
//     //   print(a.id);
//     //   print(a.data());
//     // }

//     var allmsgwithlive =
//         await FirebaseFirestore.instance.collection('msgdata').snapshots();
//     await for (var snap in allmsgwithlive)
//       for (var a in snap.docs) {
//         print(a.data());
//       }
// this code copy from chrome but after 2 hour now i understamnd fuckkkk
  // final allmsg = await FirebaseFirestore.instance
  //     .collection('msgdata')
  //     .get()
  //     .then((value) {
  //   for (final doc in value.docs) {
  //     print('${doc.id}=> ${doc.data()}');
  //   }
  // });

  // print(allmsg.);
  //}

  @override
  Widget build(BuildContext context) {
    print("$user hhhhhhh ");
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "chat screen of $user",
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  auth.signOut();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close))
          ],
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('msgdata')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.red,
                        ),
                      );
                    }

                    List<msgbubble> listofmsgandsender = [];

                    // if snapshot have data than all data go to thier specific variable and all varible send to msgbubble class or widget
                    //and that msgbubble class or widget store in list named listofmsgandsender
                    if (snapshot.hasData) {
                      final allmessages = snapshot.data!.docs.reversed;
                      for (final meassage in allmessages) {
                        final msgusername = meassage['sender'];
                        final msgtext = meassage['text'];
                        final time = meassage['time'];
                        final myString = time;

                        //this line do 14:22:11 to 1442211 (insort : katheseeeee)
                        int timeindex =
                            int.parse(myString.replaceAll(RegExp(':'), ''));

                        final msgtexttowidget = msgbubble(msgtext, msgusername,
                            (user! == msgusername), time, timeindex);
                        print(msgtext);
                        listofmsgandsender.add(msgtexttowidget);

                        // are ****** aa kem thayu kay khabr nay pan aa 4 line ne lidhe message latest timewise avese yoooooo
                        //this list is list of widget or class  and i have to sort this list by inside that widget property.
                        //so .sort( make 2 object ) than in funtion both object.property  compare and result is they sort in asc or desc
                        //samjay to thik future na milan nito  kay nay okkkkkkkkk...
                        listofmsgandsender.sort(((msgbubble a, msgbubble b) {
                          return b.timeindex
                              .toString()
                              .compareTo(a.timeindex.toString());
                        }));
                        print("mmmm $listofmsgandsender");
                      }
                    }
                    return Expanded(
                        child: ListView(
                            reverse: true, children: listofmsgandsender));
                  }),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Flexible(
                      child: TextField(
                    controller: msgtextcontoller,
                    onChanged: (value) {
                      meassagetext = value;
                    },
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 20))),
                  )),
                  ElevatedButton(
                      onPressed: () async {
                        msgtextcontoller.clear();
                        DateTime now = DateTime.now();
                        String time = (now.hour.toString() +
                            ":" +
                            now.minute.toString() +
                            ":" +
                            now.second.toString());

                        print(' ${now.hour}:${now.minute}:${now.second}');
                        await firestore.collection('msgdata').add({
                          'text': meassagetext,
                          'sender': user,
                          'time': time
                        });
                        //getmsg();
                      },
                      child: Text("SEND"))
                ],
              )
            ],
          ),
        ));
  }
}

// this is bubble sort this only decorate textmsgbox and give design bas ......
class msgbubble extends StatelessWidget {
  String msgtext;
  String msgusername;
  String time;
  int timeindex;
  bool isme;
  msgbubble(
      this.msgtext, this.msgusername, this.isme, this.time, this.timeindex);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
          crossAxisAlignment:
              isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(msgusername),
            Material(
              borderRadius: BorderRadiusDirectional.only(
                  topStart: isme ? Radius.circular(7) : Radius.circular(0),
                  topEnd: isme ? Radius.circular(0) : Radius.circular(7),
                  bottomStart: Radius.circular(7),
                  bottomEnd: Radius.circular(7)),
              elevation: 14,
              color: isme ? Colors.amber[300] : Colors.blue[300],
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 5.0),
                child: Text(
                  " $msgtext",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            Text(time),
          ]),
    );
  }
}
