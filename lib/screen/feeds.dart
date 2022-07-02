import 'dart:convert';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Feeds extends StatefulWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
    getData();
  }

  List data = [];
  List<String> imgUrl = [];
  bool show = false;
  getData() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.unsplash.com/photos/?client_id=2xlXTgPFrfhxgr3p3feOVuis3-S-59krIoJRGhJ-_vs'));
    data = jsonDecode(response.body);
    // print(data.elementAt(0)['urls']['regular']);
    _assign();
    if (mounted) {
      setState(() {
        show = true;
      });
      // ignore: avoid_print
    }
    // print(imgData);
  }

  _assign() {
    print(data.length);
    // print(data.elementAt(1)['urls']['regular']);
    for (var i = 0; i < data.length; i++) {
      imgUrl.add(data.elementAt(i)['urls']['regular']);
    }
  }

  List<String> images = [
    "https://www.setaswall.com/wp-content/uploads/2018/08/Spiderman-Wallpaper-76-1280x720.jpg",
    "https://images.hdqwalls.com/download/spiderman-peter-parker-standing-on-a-rooftop-ix-1280x720.jpg",
    "https://images.wallpapersden.com/image/download/peter-parker-spider-man-homecoming_bGhsa22UmZqaraWkpJRmZ21lrWxnZQ.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvUgui-suS8DgaljlONNuhy4vPUsC_UKvxJQ&usqp=CAU",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feeds '),
        centerTitle: true,
      ),
      backgroundColor:
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Colors.grey.shade900
              : Colors.white,
      body: ListView.builder(
        itemCount: imgUrl.length,
        itemBuilder: (BuildContext context, int index) {
          return show
              ? Card(
                  child: Image.network(imgUrl.elementAt(index)),
                )
              : Container();
        },
      ),
    );
  }
}

























// class _FeedsState extends State<Feeds> {
//   UploadTask? task;
//   File? file;
//   @override
//   Widget build(BuildContext context) {
//     final String fileName =
//         file != null ? basename(file!.path) : 'No File Selected';
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: Container(
//               height: 35,
//               width: 200,
//               margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//               child: ElevatedButton(
//                 style: ButtonStyle(
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(Colors.green.shade300),
//                 ),
//                 onPressed: () {
//                   selectFile();
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     Icon(Icons.attach_file_outlined),
//                     SizedBox(
//                       width: 16,
//                     ),
//                     Text(
//                       'Select File',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Center(
//             child: Text(
//               fileName,
//               style: const TextStyle(
//                 fontSize: 10,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Center(
//             child: Container(
//               height: 35,
//               width: 200,
//               margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//               child: ElevatedButton(
//                 style: ButtonStyle(
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(Colors.green.shade300),
//                 ),
//                 onPressed: () {
//                   uploaFile();
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     Icon(Icons.cloud_upload_outlined),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text(
//                       'Upload File',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           task != null ? buildUploadState(task!) : Container(),
//         ],
//       ),
//     );
//   }

//   Future selectFile() async {
//     final result = await FilePicker.platform.pickFiles(
//       allowMultiple: false,
//     );
//     if (result == null) return;
//     final path = result.files.single.path;
//     setState(() {
//       file = File(path.toString());
//       // ignore: avoid_print
//       print(file);
//     });
//   }

//   Future uploaFile() async {
//     if (file == null) return;

//     final fileName = basename(file!.path);
//     final destination = 'file/$fileName-${DateTime.now()}';

//     task = FirebaseApi.uploadFile(destination, file!);
//     setState(() {});

//     if (task == null) return;
//     final snapShot = await task!.whenComplete(() {});
//     final urlDownload = await snapShot.ref.getDownloadURL();

//     // ignore: avoid_print
//     print('Download Link: $urlDownload');
//   }

//   Widget buildUploadState(UploadTask task) {
//     return StreamBuilder<TaskSnapshot>(
//       stream: task.snapshotEvents,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final snap = snapshot.data;
//           final progress = snap!.bytesTransferred / snap.totalBytes;
//           final percentage = (progress * 100).toStringAsFixed(2);
//           return Text(
//             '$percentage %',
//             style: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           );
//         } else {
//           return Container();
//         }
//       },
//     );
//   }
// }
