import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:kurdistan_visitor/screens/welcome_page.dart';
import 'package:kurdistan_visitor/welcome_main.dart';
// import 'package:kurdistan_visitor/welcompages/welcome_page.dart';

import 'welcomepages/welcome_page.dart';

class CurrentChk extends StatefulWidget {
  const CurrentChk({Key? key}) : super(key: key);

  @override
  _CurrentChkState createState() => _CurrentChkState();
}

class _CurrentChkState extends State<CurrentChk> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late bool currentUser = false;
  inputData() async {
    // ignore: avoid_print
    print('the user is :');
    final User? user = auth.currentUser;
    // final uid = user!.uid;
    // print('UID:${uid}');
    // ignore: avoid_print
    print(user);
    if (user != null) {
      setState(() {
        currentUser = true;
        // return

        // Navigator.pushReplacementNamed(context, 'welcome_main');
      });
    } else {
      currentUser = false;

      // Navigator.pushReplacementNamed(context, 'welcome');
    }
    // here you write the codes to input the data into firestore
  }

  // final User? user = auth.currentUser;
  //   final uid = user!.uid;
  @override
  Widget build(BuildContext context) {
    inputData();
    return currentUser ? const WelcomMain() : const WelcomePage();
  }
}
