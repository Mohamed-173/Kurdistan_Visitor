import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:kurdistan_visitor/connection/internet_checker.dart';
// import 'package:kurdistan_visitor/currentchk.dart';
// import 'package:kurdistan_visitor/pages/map.dart';
import 'screen/notification.dart';
import 'screen/profile.dart';
import '/screen/map.dart';
import './screen/feeds.dart';
import './screen/home.dart';
// import 'package:carousel_pro/carousel_pro.dart';

class WelcomMain extends StatefulWidget {
  const WelcomMain({Key? key}) : super(key: key);

  // const WelcomMain({Key key}) : super(key: key);

  @override
  _WelcomMainState createState() => _WelcomMainState();
}

class _WelcomMainState extends State<WelcomMain> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    chd();
    // intchr();
  }

  void getCurrentUser() async {
    setState(() {
      try {
        final user = _auth.currentUser;
        if (user != null) {
          loggedInUser = user;
          setState(() {
            intCon = true;
          });
          // ignore: avoid_print
          print(loggedInUser);
        }
      } catch (e) {
        // ignore: avoid_print
        setState(() {
          intCon = false;
        });
        // ignore: avoid_print
        print(e);
      }
    });
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
            intCon = true;
            // ignore: avoid_print
            print('internet Connection  is : $intCon');
          });
        }
      } else {
        if (mounted) {
          setState(() {
            intCon = false;
            // this._hasInternet = _hasInternet;
            // ignore: avoid_print
            print('internet Connection  is : $intCon');
          });
        }
      }
    });
  }

  // Future<bool> intchr() async {
  //   bool chr = await IntChr().chd2();
  //   setState(() {
  //     intCon = chr;
  //     print('internet Connection  is : $intCon');
  //   });
  //   return chr;
  // }

  bool intCon = true;

  int selectedIndex = 0;
  final screens = [
    const HomePage(),
    const Feeds(),
    const Maps(),
    const Notification1(),
    const Profile(),
  ];
  List<IconData> data = [
    Icons.home_outlined,
    Icons.image_outlined,
    Icons.fmd_good_outlined,
    Icons.notification_add_outlined,
    Icons.person_outline_sharp
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,

      body: Container(
        decoration: BoxDecoration(
            color: MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Colors.grey.shade900
                : Colors.white,
            image: intCon
                ? DecorationImage(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2),
                      BlendMode.dstATop,
                    ),
                    image: const AssetImage("assets/images/rwandz.jpg"),
                    fit: BoxFit.cover)
                : const DecorationImage(
                    colorFilter: ColorFilter.mode(
                      Colors.transparent,
                      BlendMode.dstATop,
                    ),
                    image: AssetImage("assets/images/rwandz.jpg"),
                    fit: BoxFit.cover)),
        child: Stack(
          children: [
            intCon ? screens[selectedIndex] : noInternet(context),
            bottomNav(),
          ],
        ),
      ),
      backgroundColor: Colors.black.withOpacity(0.1),
      // ignore: avoid_unnecessary_containers
      // bottomNavigationBar: bottomNav(),
    );
  }

  Center noInternet(BuildContext context) {
    return Center(
      child: Column(
        children: [
          intCon
              ? Container()
              : Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.175),
                  padding: const EdgeInsets.all(10),
                  // height: 400,
                  width: double.infinity,
                  // height: MediaQuery.of(context).size.height,
                  // width: MediaQuery.of(context).size.width,
                  // color: Colors.white,
                  child: Image.asset(
                    'assets/isomatric/lost_online.png',
                    height: 300,
                    width: 300,
                    fit: BoxFit.fill,
                  ),
                ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
            child: const Text(
              'Whoops! ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff6762bf),
                letterSpacing: 5,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: const Text(
                'There seems to be a problem with \n your Network Connection ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff78769c),
                  // letterSpacing: 5,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 125,
            margin: const EdgeInsets.only(top: 20),
            child: Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(10),
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xff6762bf),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(
                          // color: Colors.white,
                          ),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Try Again',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget bottomNav1() {
  //   return Container(
  //     height: MediaQuery.of(context).size.height * 0.1,
  //     child: Align(
  //         alignment: Alignment.bottomCenter,
  //         child: BottomNavigationBar(
  //           backgroundColor:
  //               Colors.black.withOpacity(0.1), //here set your transparent level
  //           elevation: 0,
  //           selectedItemColor: Colors.blueAccent,
  //           unselectedItemColor: Colors.white,
  //           type: BottomNavigationBarType.fixed,
  //           currentIndex: 0,
  //           showSelectedLabels: false,
  //           showUnselectedLabels: false,
  //           items: [
  //             BottomNavigationBarItem(
  //                 icon: Icon(Icons.notifications_none, size: 30),
  //                 title: Text('Notifications')),
  //             BottomNavigationBarItem(
  //                 icon: Icon(Icons.search, size: 30), title: Text('Search')),
  //             BottomNavigationBarItem(
  //                 icon: Icon(Icons.perm_identity, size: 30),
  //                 title: Text('User'))
  //           ],
  //         )),
  //   );
  // }

  Widget bottomNav() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        // color: Colors.black.withOpacity(0.1),
        // data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        padding: const EdgeInsets.only(bottom: 3),
        child: Material(
          // elevation: 10,
          borderRadius: BorderRadius.circular(20),
          color: Colors.black.withOpacity(0.1),
          // ignore: sized_box_for_whitespace
          child: Container(
            color: Colors.transparent,
            // height: 50,
            height: MediaQuery.of(context).size.height * 0.05,
            width: double.infinity,
            child: ListView.builder(
              itemCount: data.length,
              // padding: EdgeInsets.symmetric(horizontal: 10),
              // ignore: avoid_unnecessary_containers
              itemBuilder: (ctx, i) => Container(
                // padding: const EdgeInsets.symmetric(horizontal: 15),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = i;
                      // if (i == 3) {
                      //   Navigator.pushNamed(context, 'test');
                      // }
                    });
                  },
                  child: Container(
                    // height: 5,
                    width: MediaQuery.of(context).size.width * 0.20,
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.dark
                        ? Colors.grey.shade900.withOpacity(0.3)
                        : Colors.white.withOpacity(0.3),
                    child: Center(
                      child: Container(
                        //its the red underline width
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: double.maxFinite,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: i == selectedIndex
                                ? const Border(
                                    bottom: BorderSide(
                                      width: 3.0,
                                      // style: ,
                                      color: Colors.red,
                                    ),
                                  )
                                : null,
                          ),
                          child: Icon(
                            data[i],
                            size: 35,
                            color: i == selectedIndex
                                ? Colors.white
                                : Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
      ),
    );
  }
}
