import 'package:flutter/material.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        centerTitle: true,
      ),
      backgroundColor:
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Colors.grey.shade900
              : Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.175),
            padding: const EdgeInsets.all(10),
            // height: 400,
            width: double.infinity,
            // height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width,
            // color: Colors.white,
            child: Image.asset(
              'assets/isomatric/undraw_process.png',
              height: 300,
              width: 300,
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: const Text(
                'The page is under process',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff78769c),
                  // letterSpacing: 5,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
