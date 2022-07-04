// import 'package:data_connection_checker/data_connection_checker.dart';
// import 'dart:async';

// import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// import './forget_password.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:email_validator/email_validator.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

// import 'dart:io';

class Login extends StatefulWidget {
  final bool? chd1;
  const Login({Key? key, this.chd1}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _hasInternet = false;

  @override
  void initState() {
    super.initState();
    // ignore: avoid_print
    print(widget.chd1);
    chd();
    chd2();
  }

  Future<void> chd() async {
    InternetConnectionChecker().onStatusChange.listen((status) {
      final _hasInternet = status == InternetConnectionStatus.connected;

      // print(status.toString());
      // ignore: avoid_print
      print(' has_internet:  ${_hasInternet.toString()}');
      // chk(hasinternet: has_internet1);

      if (_hasInternet == true) {
        if (mounted) {
          setState(() {
            // _internet7 = _hasInternet;
            this._hasInternet = _hasInternet;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            this._hasInternet = _hasInternet;
          });
        }
      }
    });
  }

  String? validator(Validator? validate, String? value) {
    if (validate != null) {
      if (validate == Validator.email) {
        if (!RegExp(
                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
            .hasMatch(_email.value.text)) {
          return ' Email UnValid';
        }
      }
      //For Password
      if (validate == Validator.password) {
        if (_password.value.text.length < 6) {
          return 'morethan 6 charecter';
        }
      }
    }
    return null;
  }

  Future<void> chd2() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      // ignore: avoid_print
      print('The result is true of internet connection');
      setState(() {
        _hasInternet = result;
      });
      chd();
    } else {
      // ignore: avoid_print
      print('No internet :( Reason:');
      // ignore: avoid_print
      print(InternetConnectionChecker().hasConnection);
    }
  }

  @override
  void dispose() {
    chd();

    super.dispose();
  }

// Be sure to cancel subscription after you are done
// Firebase.initializeApp();

  final auth = FirebaseAuth.instance;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _forgetMail = TextEditingController();

  late FirebaseAuthException _errorMessages;
  // var _bgt = MainAxisAlignment.center;

  bool isSpin = false;
  bool _iswrong = false;
  bool _validate = false;
  final bool _iswrong1 = false;
  bool _validate1 = false;
  bool _validate2 = false;
  bool _showPass = false;
  bool _border = false;
  // bool _alt = false;
  final List<double> _atTabField = [0, 100];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Center(
        child: ModalProgressHUD(
          inAsyncCall: isSpin,
          child: SingleChildScrollView(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pop(context);
              },
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      // child: showAlt(context),
                      ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Navigator.pop(context);
                          _border = false;
                        },
                        child: GestureDetector(
                          onTap: () {
                            _border = true;
                            // print(' at click........:   $_border');
                            FocusScope.of(context).unfocus();
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.fromLTRB(
                              0,
                              // 50,
                              _border ? _atTabField[0] : _atTabField[1],
                              0,
                              MediaQuery.of(context).viewInsets.bottom,
                            ),
                            margin: EdgeInsets.fromLTRB(
                              0,
                              // 50,
                              _border ? _atTabField[1] : _atTabField[0],
                              0,
                              0,
                            ),
                            child: Card(
                              color: Colors.white,
                              // margin: EdgeInsets.only(bottom: 10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                // mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 10,
                                      ),
                                      child: const Text(
                                        'Log In',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 8,
                                    ),
                                    child: Card(
                                      child: TextField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        controller: _email,
                                        decoration: InputDecoration(
                                          errorText: validator(Validator.email,
                                              _email.value.text),
                                          prefixIcon: const Icon(Icons.email),
                                          labelText: 'Email...',
                                        ),
                                        autofillHints: const [
                                          AutofillHints.email
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 8,
                                    ),
                                    child: Card(
                                      child: TextField(
                                        controller: _password,
                                        obscureText: !_showPass,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          errorText: validator(
                                              Validator.password,
                                              _password.value.text),
                                          prefixIcon: const Icon(Icons.lock),
                                          suffixIcon: IconButton(
                                              color: !_showPass
                                                  ? Colors.grey
                                                  : Colors.blue,
                                              onPressed: () {
                                                setState(() {
                                                  _showPass = !_showPass;
                                                });
                                              },
                                              icon: !_showPass
                                                  ? const Icon(Icons
                                                      .visibility_off_outlined)
                                                  : const Icon(Icons
                                                      .visibility_outlined)),
                                          labelText: 'Password',
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .padding
                                              .bottom),
                                      child: TextButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (c) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Forget Password'),
                                                  // content: Text(' Enter Email'),
                                                  actions: [
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        // vertical: 8,
                                                        horizontal: 8,
                                                      ),
                                                      child: const Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                            ' Enter Email'),
                                                      ),
                                                    ),
                                                    Container(
                                                      // color: Colors.amber,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 8,
                                                        horizontal: 8,
                                                      ),
                                                      child: Card(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            TextField(
                                                              onTap: () async {
                                                                setState(() {
                                                                  _forgetMail
                                                                          .text
                                                                          .isEmpty
                                                                      ? _validate2 =
                                                                          true
                                                                      : _validate2 =
                                                                          false;
                                                                });
                                                              },
                                                              keyboardType:
                                                                  TextInputType
                                                                      .emailAddress,
                                                              controller:
                                                                  _forgetMail,
                                                              decoration:
                                                                  InputDecoration(
                                                                errorText: _validate2
                                                                    ? 'Required'
                                                                    : EmailValidator.validate(_forgetMail.text)
                                                                        ? null
                                                                        : _forgetMail.text.isNotEmpty
                                                                            ? 'Not Validate Email'
                                                                            : null,
                                                                prefixIcon:
                                                                    const Icon(Icons
                                                                        .email),
                                                                labelText:
                                                                    'Email...',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    // ignore: sized_box_for_whitespace
                                                    Container(
                                                      width: 450,
                                                      height: 40,
                                                      // padding:
                                                      //     EdgeInsets.symmetric(
                                                      //         vertical: 8),
                                                      child: TextButton(
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all<Color>(
                                                                        Colors
                                                                            .red),
                                                            shape: MaterialStateProperty
                                                                .all<
                                                                    RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0),
                                                                side:
                                                                    const BorderSide(
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              ),
                                                            )),
                                                        onPressed: () {
                                                          if (_hasInternet ==
                                                              true) {
                                                            setState(() {
                                                              auth
                                                                  .sendPasswordResetEmail(
                                                                      email: _forgetMail
                                                                          .text)
                                                                  .catchError(
                                                                      (e) {
                                                                // ignore: avoid_print
                                                                print(e
                                                                    .toString());
                                                              }).then((value) {
                                                                Navigator.pop(
                                                                    context);
                                                                // ignore: avoid_print
                                                                print(
                                                                    'done the send password reset');
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'A password reset link has been sent to ${_forgetMail.text}',
                                                                    ),
                                                                  ),
                                                                );
                                                              });
                                                            });
                                                          } else {
                                                            // if we dont have internet connection at we send forget email
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder: (e1) {
                                                                  // _errorMessages = e;
                                                                  return AlertDialog(
                                                                    content:
                                                                        const Text(
                                                                            'Check your internet connection cnd try again.'),
                                                                    title: const Text(
                                                                        'Are you offline?'),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          'Dissmis!',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            decoration:
                                                                                TextDecoration.underline,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  );
                                                                }).then((value) {
                                                              // isSpin = false;
                                                              return;
                                                            });
                                                            return;
                                                          }
                                                        },
                                                        child: const Text(
                                                          'Send',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        child: const Text(
                                          'Forget Password1',
                                          style: TextStyle(
                                            color: Colors.black,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.transparent,
                                    width: 450,
                                    height: 80,
                                    padding: const EdgeInsets.all(8),
                                    child: TextButton(
                                      child: const Text(
                                        'Log In1',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.red),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              side: const BorderSide(
                                                color: Colors.red,
                                              ),
                                            ),
                                          )),
                                      onPressed: () async {
                                        setState(() {
                                          _email.text.isEmpty
                                              ? _validate1 = true
                                              : _validate1 = false;
                                          _password.text.isEmpty
                                              ? _validate = true
                                              : _validate = false;
                                        });
                                        if (_email.text.isNotEmpty &&
                                            _password.text.isNotEmpty) {
                                          try {
                                            if ((EmailValidator.validate(
                                                    _email.text) &&
                                                _password.text.length >= 6)) {
                                              isSpin = true;

                                              if (_hasInternet == true ||
                                                  widget.chd1 == true) {
                                                // ignore: avoid_print
                                                print(
                                                    '......... has_internet:$_hasInternet ');

                                                // ignore: avoid_print
                                                print(
                                                    'YAY! Free cute dog pics!');
                                                // print(_password.text.isNotEmpty);
                                                final newUser = await auth
                                                    .signInWithEmailAndPassword(
                                                  email: _email.text,
                                                  password: _password.text,
                                                )
                                                    .whenComplete(() {
                                                  // setState(() {
                                                  //   // isSpin = false;
                                                  // });
                                                }).catchError((e) async {
                                                  // ignore: avoid_print
                                                  print(
                                                      'oooooooooooooooooooooooooooooooooooo');
                                                  setState(() {
                                                    isSpin = false;
                                                  });

                                                  // print(
                                                  // '...................................... ${e.toString()}');
                                                  setState(() {
                                                    showDialog(
                                                        context: context,
                                                        builder: (e1) {
                                                          _errorMessages = e;
                                                          return AlertDialog(
                                                            content: const Text(
                                                                'Invalid email or password'),
                                                            title: const Text(
                                                                'Login error'),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  //TODO:Fixing wrong pop
                                                                  setState(() {
                                                                    // print(Navigator
                                                                    //     .defaultRouteName);
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                                  //  Future.delayed(
                                                                  //     Duration(
                                                                  //         seconds:
                                                                  //             5));
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'Dismiss',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          );
                                                        }).then((value) {
                                                      // isSpin = false;
                                                      // return;
                                                    });

                                                    // isSpin = true;
                                                    _iswrong = true;
                                                    // wrong = e.toString();
                                                  });
                                                  _errorMessages = e;

                                                  // ignore: avoid_print
                                                  print(e.runtimeType);
                                                  // ignore: avoid_print
                                                  print(_errorMessages.code);
                                                });
                                                setState(() {
                                                  // ignore: unnecessary_null_comparison
                                                  if (newUser != null) {
                                                    Navigator.pop(context);
                                                    Navigator
                                                        .pushReplacementNamed(
                                                            context,
                                                            'welcome_main');
                                                  }
                                                });

                                                setState(() {
                                                  // isSpin = false;
                                                });
                                              } else {
                                                setState(() {
                                                  isSpin = false;
                                                  showDialog(
                                                      context: context,
                                                      builder: (e1) {
                                                        // _errorMessages = e;
                                                        return AlertDialog(
                                                          content: const Text(
                                                              'Check your internet connection cnd try again.'),
                                                          title: const Text(
                                                              'Are you offline?'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  Navigator.pop(
                                                                      context);
                                                                });

                                                                // Navigator.of(
                                                                //         context)
                                                                //     .pop();
                                                              },
                                                              child: const Text(
                                                                'Dissmis!',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        );
                                                      }).then((value) {
                                                    // isSpin = false;
                                                    return;
                                                  });

                                                  // isSpin = true;
                                                  _iswrong = true;
                                                  // wrong = e.toString();
                                                });

                                                // ignore: avoid_print
                                                print('No internet :( Reason:');
                                                // print(DataConnectionChecker()
                                                //     .lastTryResults);
                                              }
                                              // ets end of check />

                                              // print(_email.text);
                                              // print(_password.text);
                                            } else {
                                              // ignore: avoid_print
                                              print(
                                                  'invildate email or Password  password must be greater than and equal 6 character');

                                              return;
                                            }
                                          } catch (e) {
                                            // ignore: avoid_print
                                            print(e);
                                          }
                                        } else {
                                          // isSpin = false;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 160,
                            height: 2,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Text(
                                'OR',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.75),
                                ),
                              )),
                          Container(
                            width: 160,
                            height: 2,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.transparent,
                        width: 450,
                        height: 70,
                        // padding: EdgeInsets.all(8),
                        child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                          onPressed: () {},
                          child: const Text('Continue with Google',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              )),
                        ),
                        //
                        // FlatButton(
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(12)),
                        //   color: Colors.blue,
                        //   onPressed: () {},
                        //   child: Text(
                        //     'Continue with Google',
                        //     style: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 20,
                        //     ),
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showAlt(BuildContext ctd) {
    showDialog(
        context: ctd,
        builder: (d) {
          return AlertDialog(
            content: Container(
              color: Colors.amberAccent,
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.error_outline),
                  ),
                  Expanded(
                    child: Text(
                        'A password reset link has been sent to ${_forgetMail.text}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

enum Validator { email, password }
