import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor:
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Colors.grey.shade900
              : Colors.white,
      appBar: AppBar(
        title: const Text('Profile '),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ignore: sized_box_for_whitespace
          Container(
            height: 100,
            width: 100,
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://s3.us-west-2.amazonaws.com/images.unsplash.com/application-1641387558175-d5f3fb116a08image'),
            ),
          ),
          // ClipOval(
          //   child: Container(
          //     //color: Colors.green,
          //     height: 120.0, // height of the button
          //     width: 120.0, // width of the button
          //     decoration: BoxDecoration(
          //         color: Colors.green,
          //         border: Border.all(
          //             color: Colors.white,
          //             width: 10.0,
          //             style: BorderStyle.solid),
          //         // boxShadow: const [
          //         //   BoxShadow(
          //         //       color: Colors.grey,
          //         //       offset: Offset(21.0, 10.0),
          //         //       blurRadius: 20.0,
          //         //       spreadRadius: 40.0)
          //         // ],
          //         shape: BoxShape.circle),
          //     child: Center(
          //       // child: ,
          //         child: Text('${_auth.currentUser!.email}',
          //             style: TextStyle(color: Colors.white.withOpacity(0.6)))
          //             ),
          //   ),
          // ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              height: 20,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: Colors.blue.shade200,
              ),
              child: FittedBox(
                child: Text(
                  '${_auth.currentUser!.email}',
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green.shade300),
              ),
              onPressed: () {
                // ignore: avoid_print
                print(_auth.currentUser);
              },
              child: const Text(
                'current user',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green.shade300),
              ),
              onPressed: () async {
                await signout().whenComplete(() {
                  Navigator.of(context).popAndPushNamed('welcome');
                });
              },
              child: const Text(
                'logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> signout() async {
    try {
      setState(() async {
        await _auth.signOut();
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
