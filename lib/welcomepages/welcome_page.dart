import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:kurdistan_visitor/screen/home.dart';
import '../authentication/register.dart';
import '../authentication/new_login.dart';
// import 'logintest.dart';
// import 'package:flutter/services.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // inputData();
  }

  late bool currentUser = false;

  final FirebaseAuth auth = FirebaseAuth.instance;

  void _startCreateLogin(BuildContext ctx, bool chosen) {
    showModalBottomSheet(

        // isDismissible: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: ctx,
        builder: (e) {
          return Container(
            // height: MediaQuery.of(ctx).size.height,

            // width: MediaQuery.of(ctx).size.width,
            height: double.maxFinite,
            width: double.maxFinite,
            // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            // padding: EdgeInsets.only(
            //   bottom: MediaQuery.of(e).viewInsets.bottom,
            // ),
            // color: Colors.amber,
            color: Colors.transparent,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pop(e);
                FocusScope.of(e).unfocus();
              },
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: chosen ? const Login() : const Register(),
                  // Login1(),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([]);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    // ));
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/1084_0.jpg'),
            // image: AssetImage('assets/images/rwandz.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: [
            // Container(
            //   height: double.maxFinite,
            //   width: double.maxFinite,
            //   color: Colors.red,
            //   child: FittedBox(
            //     child: Image.asset('assets/images/1084_0.jpg'),
            //     fit: BoxFit.cover,
            //   ),
            // ),

            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 100, 10, 10),
                  child: const Text(
                    'WELCOME',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        letterSpacing: 1.0),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 10, 10),
                  child: const Text(
                    'Lets Going Kurdistan',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        letterSpacing: 1.0),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 50,
                              width: 175,
                              decoration: const BoxDecoration(),
                              child: TextButton(
                                style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black.withOpacity(0.20)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.black.withOpacity(0.40)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  _startCreateLogin(context, true);
                                },
                                child: const Text(
                                  'Log In',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 175,
                              decoration: const BoxDecoration(),
                              child: TextButton(
                                style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black.withOpacity(0.20)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.black.withOpacity(0.40)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  _startCreateLogin(context, false);
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
