// import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GlobPlaces extends StatefulWidget {
  final String? urlImage;
  const GlobPlaces({Key? key, this.urlImage}) : super(key: key);

  @override
  _GlobPlacesState createState() => _GlobPlacesState();
}

class _GlobPlacesState extends State<GlobPlaces> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            widget.urlImage!,
          ),
          // image: const AssetImage("assets/images/rwandz.jpg"),
          fit: BoxFit.fitHeight,
        ),
      ),
      height: double.infinity,
      width: double.infinity,
      // color: Colors.amber,
    );
  }

  Container newMethod() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(widget.urlImage!),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // ignore: avoid_unnecessary_containers
            Container(
              // height: 600,
              // width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),

                child: FittedBox(
                  child: CachedNetworkImage(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    // fit: BoxFit.cover,
                    imageUrl: widget.urlImage!,
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error_outline),
                    placeholder: (context, url) {
                      return Container(
                        color: Colors.white,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade500,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            // width: 300,
                            // height: 500,
                            color: Colors.green,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Image.network(
                //   urlImage,
                //   fit: BoxFit.cover,
                // ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
