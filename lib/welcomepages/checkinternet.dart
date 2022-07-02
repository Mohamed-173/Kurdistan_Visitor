import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';

class InternetChecker7 extends StatefulWidget {
  const InternetChecker7({Key? key}) : super(key: key);

  @override
  _InternetChecker7State createState() => _InternetChecker7State();
}

class _InternetChecker7State extends State<InternetChecker7> {
  bool _hasInternet = false;
  ConnectivityResult result = ConnectivityResult.none;

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((result) {
      chk(network: result);
      // ignore: avoid_print
      print('result:  ${result.toString()}');
    });

    InternetConnectionChecker().onStatusChange.listen((status) {
      final _hasInternet = status == InternetConnectionStatus.connected;

      // ignore: avoid_print
      print(status.toString());
      // ignore: avoid_print
      print(' has_internet:  ${_hasInternet.toString()}');
      // chk(hasinternet: has_internet1);

      setState(() {
        _internet7 = _hasInternet;
        this._hasInternet = _hasInternet;
      });
    });
  }

  void chk({required ConnectivityResult network}) {
    if (network != ConnectivityResult.none) {
      if (network == ConnectivityResult.mobile) {
        setState(() {
          _mobiledata = true;
          return;
        });
      } else if (network == ConnectivityResult.wifi) {
        setState(() {
          _wifi7 = true;
          return;
        });
      } else if (network == ConnectivityResult.ethernet) {
        setState(() {
          _ethernet = true;
          return;
        });
      } else {
        setState(() {
          _mobiledata = false;
          _wifi7 = false;
          return;
        });
      }
    } else {
      setState(() {
        _mobiledata = false;
        _wifi7 = false;
        return;
      });
    }
    // ignore: avoid_print
    print('....network. chk() function run ...........: $network');
  }

  bool _wifi7 = false;
  bool _mobiledata = false;
  bool _internet7 = false;
  bool _ethernet = false;

  void checkinternet() async {
    final color = _hasInternet ? Colors.green : Colors.red;
    final text = _hasInternet ? 'internet' : 'no internet';
    if (result == ConnectivityResult.mobile) {
      showSimpleNotification(
        Text(
          '$text: Mobile Network',
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        background: color,
      );
    } else if (result == ConnectivityResult.wifi) {
      showSimpleNotification(
        Text(
          '$text: Wifi Network',
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        background: color,
      );
    } else {
      showSimpleNotification(
        Text(
          '$text: No Network',
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        background: color,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Container(
              height: 500,
              width: 500,
              color: Colors.tealAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Wifi Network: $_wifi7'),
                  Text('Mobile Network: $_mobiledata'),
                  Text('Ethernet Network: $_ethernet'),
                  Text('Internet Connection: $_internet7'),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.amber)),
                    onPressed: () async {
                      _hasInternet =
                          await InternetConnectionChecker().hasConnection;
                      result = await Connectivity().checkConnectivity();

                      setState(() {
                        InternetConnectionChecker()
                            .onStatusChange
                            .listen((event) {
                          //          ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     content: Text(
                          //         'wifi:$_wifi7  ,  Data:$_mobiledata  , internetconnect:$_internet7'),
                          //   ),
                          // );
                        });
                      });

                      final color = _hasInternet ? Colors.green : Colors.red;
                      final text = _hasInternet ? 'internet' : 'no internet';
                      if (result == ConnectivityResult.mobile) {
                        showSimpleNotification(
                          Text(
                            '$text: Mobile Network',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                          background: color,
                        );
                      } else if (result == ConnectivityResult.wifi) {
                        showSimpleNotification(
                          Text(
                            '$text: Wifi Network',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                          background: color,
                        );
                      } else {
                        showSimpleNotification(
                          Text(
                            '$text: No Network',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                          background: color,
                        );
                      }
                    },
                    child: const Text('Press to Check or reset (;'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
