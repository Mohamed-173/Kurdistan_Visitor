// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kurdistan_visitor/connection/internet_checker.dart';
import 'package:kurdistan_visitor/firebasereal/addtop.dart';
import 'package:kurdistan_visitor/firebasereal/getdata.dart';
import 'package:kurdistan_visitor/screens2/globplaces.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    // loadData();
    // getData1();
    internetcheek();

    getData2();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    addData3;
    getData2;
  }

  final databaseRef = FirebaseDatabase.instance.reference();
  bool isLoad = false;

  final _controler = CarouselController();
  int activeIndex = 0;
  bool isAdmin = true;
  final name = TextEditingController();
  List<String> names = [];
  // List<String> ime1 = [];
  List<String> images1 = [];
  late List<GetTopPlaces> getTopplaces = [];
  late Map<dynamic, dynamic> topPlaces0;

  late List<String> imageList = [
    // "https://www.setaswall.com/wp-content/uploads/2018/08/Spiderman-Wallpaper-76-1280x720.jpg",
    // "https://images.hdqwalls.com/download/spiderman-peter-parker-standing-on-a-rooftop-ix-1280x720.jpg",
    // "https://images.wallpapersden.com/image/download/peter-parker-spider-man-homecoming_bGhsa22UmZqaraWkpJRmZ21lrWxnZQ.jpg",
    // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvUgui-suS8DgaljlONNuhy4vPUsC_UKvxJQ&usqp=CAU",
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // ignore: avoid_unnecessary_containers
      child: Container(
        // decoration: BoxDecoration(
        // image: DecorationImage(
        // colorFilter: ColorFilter.mode(
        // Colors.black.withOpacity(0.2), BlendMode.dstATop),
        // image: const AssetImage("assets/images/rwandz.jpg"),
        // fit: BoxFit.cover)),
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,

          // appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  // margin: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                  // color: Colors.red,
                  color: Colors.transparent,

                  // height: 200,
                  height: currentheight(context) * 0.15,
                  width: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
                              // margin: const EdgeInsets.symmetric(vertical: 15),
                              child: const Text(
                                'Explore',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                              // margin: const EdgeInsets.symmetric(vertical: 15),
                              child: const Text(
                                'new amaizing countries',
                                style: TextStyle(
                                  color: Colors.grey,
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  // color: Colors.amber,
                  color: Colors.transparent,
                  height: currentheight(context) * 0.85,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarouselSlider.builder(
                          carouselController: _controler,
                          options: CarouselOptions(
                            aspectRatio: 16 / 9,
                            enlargeCenterPage: true,
                            // enlargeCenterPage: true,
                            // enlargeStrategy: CenterPageEnlargeStrategy.scale,
                            enableInfiniteScroll: true,
                            // height: 550,
                            height: MediaQuery.of(context).size.height * 0.6,
                            onPageChanged: (index, reason) {
                              setState(() {
                                activeIndex = index;
                              });
                            },
                          ),
                          itemCount:
                              getTopplaces.isEmpty ? 5 : getTopplaces.length,
                          itemBuilder: (context, index, realIndex) {
                            String? urlImage;
                            String? place;
                            int? noPlace;

                            if (getTopplaces.isEmpty) {
                            } else {
                              urlImage = getTopplaces[index].imageURL;
                              place = getTopplaces[index].name;
                              noPlace = getTopplaces[index].places;
                              return buildImage(
                                  urlImage, index, place, noPlace);
                            }
                            return Container();
                          },
                        ),
                        const SizedBox(height: 15),
                        buildIndicator(),
                        isAdmin
                            ? adminPermission(context)
                            : const SizedBox(
                                height: 0,
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showShimer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade500,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        width: 300,
        height: 400,
      ),
    );
  }

  Widget buildImage(
      String urlImage, int index, String nameGPlace, int noPlace) {
    return isLoad == true
        ? Container(
            color: Colors.white,
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade500,
              highlightColor: Colors.black,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                width: 400,
                height: 400,
                color: Colors.green,
              ),
            ),
          )
        : Container(
            width: 400,

            margin: const EdgeInsets.symmetric(horizontal: 0),
            // for curveing image you need clipRRect or etc because of by default flutter ui not problem (:
            child: InkWell(
              onTap: () {
                //TODO: We need the pass urlimage and every things of this image and firebase detail
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return GlobPlaces(urlImage: urlImage);
                }));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: CachedNetworkImage(
                        imageUrl: urlImage,
                        imageBuilder: (context, imageProvider) => Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            // shape: BoxShape.circle,
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.95),
                                    BlendMode.dstATop),
                                image: imageProvider,
                                fit: BoxFit.cover),
                          ),
                        ),
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error_outline),
                        placeholder: (context, url) {
                          return Container(
                            color: Colors.white,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade500,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                width: 300,
                                height: 400,
                                color: Colors.green,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: double.maxFinite,
                            // width: ,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.1)),
                            // color: Colors.black,),

                            // margin: const EdgeInsets.fromLTRB(15, 0, 0, 20),
                            padding: const EdgeInsets.fromLTRB(15, 0, 0, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  nameGPlace,
                                  style: const TextStyle(
                                    // backgroundColor:
                                    //     Colors.black.withOpacity(0.2),
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  '$noPlace places to visit',
                                  style: const TextStyle(
                                    // backgroundColor:
                                    //     Colors.black.withOpacity(0.2),
                                    color: Colors.white,
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: getTopplaces.length,
      onDotClicked: animateToSlide,
      effect: ScaleEffect(
        spacing: 15,
        radius: 1.5,
        activeDotColor: Colors.white,
        dotColor: Colors.grey.shade800,
        dotWidth: 16,
        dotHeight: 3,
        // strokeWidth: 2,
      ),
    );
  }

  void animateToSlide(int index) {
    setState(() {
      _controler.animateToPage(index);
    });
  }

  Widget addImagesForTop() {
    return ElevatedButton(
      onPressed: () {
        // this f=methode using for select file from divice
        // selectFile();

        Navigator.push(context, MaterialPageRoute(builder: (c) {
          return AddTop(scaffoldKey: _scaffoldKey);
        }));
        // addData();
        // getData();
      },
      child: const Text(
        'Add Image',
      ),
    );
  }

//TODO showing loading effective for image loads
  Future loadData() async {
    setState(() {
      isLoad = false;
    });
    await Future.delayed(
      const Duration(seconds: 5),
    );
    // imageList.addAll(images);
    setState(() {
      isLoad = false;
    });
  }

  Widget gettingData() {
    //TODO: getting data by listen to event test
    return ElevatedButton(
      onPressed: () {
        // print('topPlaces: $topplaces');
        // this f=methode using for select file from divice
        // getData();
        // getData1();
        // ignore: unused_local_variable
        double safer = 0;
        safer = MediaQuery.of(context).size.height;
      },
      child: const Text(
        'get Data ',
      ),
    );
  }

  internetcheek() {
    //  bool chk=false;
    if (IntChr == true) {
      getData2();
    }
  }

  getData2() async {
    setState(() {
      getTopplaces = [];
    });
    // List<String> ime = imageList;

    print(
        '......................................................................');
    // final m1 =
    databaseRef.child('Places').child('TopGlobalPlaces').onValue.listen(
      (event) {
        // print('ime1:${ime1.length}: $ime1');
        // ime1.clear();
        getTopplaces = [];
        print(
            'timechange......................................................................');

        print(
            ' Event Changed${event.snapshot.value.runtimeType}  <${DateTime.now()}>:  ${event.snapshot.value}');
        final element = Map<dynamic, dynamic>.from(event.snapshot.value);
        print('value0: ${element.length}');
        print('value0: ${element.keys}');
        print('value0: ${element.runtimeType}');
        addData(element);

        // images1.clear;
        int nplace = 0;
        String imUrl = '';
        element.forEach(
          (key, value) {
            // topplaces.name = await key;
            // topplaces.imageURL = await value;

            print('value: ${value.runtimeType}');
            // ignore: unnecessary_brace_in_string_interps
            print('value: ${value}');
            print('key: ${key.runtimeType}');
            // ignore: unnecessary_brace_in_string_interps
            print('key: ${key}');

            final element1 = Map<dynamic, dynamic>.from(value);
            element1.forEach(
              (key1, value1) {
                // final element2 = Map<dynamic, dynamic>.from(value1);
                print('value10: $value1');
                // element2.forEach((key2, value2) {
                //   print('value20: $value2');
                if (key1 == 'imageURL') {
                  imUrl = value1;
                  print('imUrl:$imUrl');

                  // ime1.add(value1);
                  //TODO add to class
                  // topplaces=TopPlaces(value, valu, places)
                } else if (key1 == 'noPlace') {
                  nplace = value1;
                  print('nplace:$nplace');
                }

                // });
              },
            );
            // getTopplaces = [];
            getTopplaces.add(GetTopPlaces(key, imUrl, nplace));
            imUrl = '';
            nplace = 0;
            // ignore: unnecessary_brace_in_string_interps
            print('topplaces12: ${getTopplaces}');
            // ignore: avoid_function_literals_in_foreach_calls
            getTopplaces.forEach((ele) {
              print('elename:${ele.name}');
              print('eleimage:${ele.imageURL}');
              print('elenplace:${ele.places}');
              print(
                  '.........................................................................');
            });
          },
        );
        // addData3(ime1);

        // print('ime1:${ime1.length}: $ime1');
      },
    );

    print(
        '......................................................................');
  }

  void addImageToStorage() {}

  void addData(Map<dynamic, dynamic> topPlaces) async {
    // for (int i = 0; i <= element.length; i++) {
    //        topPlaces0.addAll(value);
    //       }
    setState(() {
      topPlaces0 = topPlaces;
      print('topPlaces0: $topPlaces0 ${topPlaces0.runtimeType}');
    });
    // ignore: unused_local_variable
    Map<String, String> tplace;
    topPlaces.forEach((key, value) {
      //TODO    using class or map to configare the every topplace for element
      // TopPlaces tplace = TopPlaces(_,imageURL, places);
    });
    // print('tplace: $tplace');

    // addData3(topPlaces0.values, topPlaces0.keys);
    topPlaces.forEach((key, value) {
      print('key: $key :: ${key.runtimeType}');
      print('key: $value ::${value.runtimeType}');
    });
  }

  void addData3(List<String> images1, List<String> names1) async {
    setState(() {
      imageList = images1;
      names = names1;
    });
  }

  double currentheight(context) {
    double media = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).size.height * 0.05;
    return media;
  }

  Row adminPermission(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        addImagesForTop(),
        const SizedBox(
          width: 15,
        ),
        gettingData(),
        ElevatedButton(
          onPressed: () {
            double safer = 0, full = 0;

            safer = MediaQuery.of(context).padding.top;
            full = MediaQuery.of(context).size.height;
            print('safer height: $safer');
            print('hight context: $full');
          },
          child: const Text(
            'hight context ',
          ),
        ),
      ],
    );
  }

  void deleteData(value1) {
    // ignore: unused_local_variable
    double safer = 0;
    setState(() {
      // imageList.remove(value1);
      // print('att delete $imageList');
    });
  }
}
