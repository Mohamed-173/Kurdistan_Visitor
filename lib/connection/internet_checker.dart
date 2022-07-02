// import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class IntChr {
  late bool internetChk;

  Future<bool> chd2() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      // ignore: avoid_print
      print('YAY! you have internet !');
      internetChk = true;
    } else {
      // ignore: avoid_print
      print('No internet :( Reason:');
      internetChk = false;
      // print(InternetConnectionChecker().hasConnection);
    }

    return internetChk;
  }
}
