import 'dart:async';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:kurdistan_visitor/api/firebase_api.dart';

@immutable
class AddTop extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const AddTop({Key? key, this.scaffoldKey}) : super(key: key);

  @override
  State<AddTop> createState() => _AddTopState();
}

class _AddTopState extends State<AddTop> {
  late final name = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.reference();

  UploadTask? task;

  File? file;

  late String imageURL = '';

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    addData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Top Global Place'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 8,
              ),
              child: Card(
                child: TextField(
                  // onTap: () {},
                  keyboardType: TextInputType.emailAddress,
                  controller: name,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.location_city_outlined),
                    labelText: 'Name...',
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 8,
              ),
              child: ElevatedButton(
                onPressed: () {
                  selectFile().whenComplete(() {});
                  // addData();
                },
                child: const Text('Add File'),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 8,
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(this.context);
                  // ignore: avoid_print

                  ScaffoldMessenger.of(widget.scaffoldKey!.currentContext!)
                      .showMaterialBanner(
                    MaterialBanner(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      overflowAlignment: OverflowBarAlignment.center,
                      content: const Text('The mession is complete'),
                      backgroundColor: Colors.grey[800],
                      actions: [
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(
                                    widget.scaffoldKey!.currentContext!)
                                .clearMaterialBanners();
                          },
                          child: const Text('DISMISS'),
                        )
                      ],
                    ),
                  );

                  Timer(const Duration(seconds: 3), () {
                    ScaffoldMessenger.of(widget.scaffoldKey!.currentContext!)
                        .clearMaterialBanners();
                  });
                  ScaffoldMessenger.of(widget.scaffoldKey!.currentContext!)
                      .showSnackBar(
                    SnackBar(
                      content: const Text('The mession is succesed.(:'),
                      duration: const Duration(
                        seconds: 5,
                      ),
                      action: SnackBarAction(
                        label: "Dissmis",
                        onPressed: () {
                          ScaffoldMessenger.of(
                                  widget.scaffoldKey!.currentContext!)
                              .removeCurrentSnackBar();
                        },
                      ),
                    ),
                  );
                  // FIXME: we need uncomment after fix remove material banner
                  uploaFile().whenComplete(() {
                    addData();
                  });

                  // addData();
                },
                child: const Text('Upload File'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addData() async {
    if (imageURL.isNotEmpty) {
      databaseRef
          .child('Places')
          .child('TopGlobalPlaces')
          .child(name.text)
          .set({
        'imageURL': imageURL,
      }).whenComplete(() {
        // Before calling setState check if the state is mounted.
        if (mounted) {
          setState(() {
            imageURL = '';
            file = null;

            Navigator.pop(this.context);
            // ignore: avoid_print
            ScaffoldMessenger.of(this.context).showMaterialBanner(
              MaterialBanner(
                content: const Text('The mession is complete'),
                backgroundColor: Colors.indigo,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(this.context);
                    },
                    child: const Text('DISMISS'),
                  )
                ],
              ),
            );
            // ignore: avoid_print
            print('the mession is completed.');
          });
        }
      });
    } else {
      // ignore: avoid_print
      print('the imageURL empty');
    }
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );
    if (result == null) return null;
    final path = result.files.single.path;
    setState(() {
      file = File(path.toString());
      // imageURL = file.toString();
      // ignore: avoid_print
      print('at Select file path   ${file.toString()}');
    });
  }

  Future uploaFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'file/topglobalplaces/$fileName-${DateTime.now()}';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;
    final snapShot = await task!.whenComplete(() {});
    final urlDownload = await snapShot.ref.getDownloadURL();

    // ignore: avoid_print
    print('Download Link: $urlDownload');
    imageURL = urlDownload;

    // ignore: avoid_print
    print(' imageURL: $imageURL');
  }
}
