import 'package:flutter/material.dart';
import 'package:photo_gallery_app/model/model_gallery.dart';

class DetailsScreen extends StatefulWidget {
  final ModelGallery modelGallery;

  const DetailsScreen({
    super.key,
    required this.modelGallery,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Details"),
        elevation: 2,
      ),
      body: screenWidth <= 600
          ? _columnPortrait(screenHeight, screenWidth)
          : _columnLandscape(screenHeight, screenWidth),
    );
  }

  Widget _columnPortrait(double screenHeight, double screenWidth) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Image.network(
            widget.modelGallery.url!,
            height: screenHeight / 3,
            width: screenWidth,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    "Title: ${widget.modelGallery.title}",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Text(
                      "ID: ${widget.modelGallery.id}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }

  Widget _columnLandscape(double screenHeight, double screenWidth) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Image.network(
          widget.modelGallery.url!,
          height: screenHeight,
          width: screenWidth / 2,
          fit: BoxFit.cover,
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Title: ${widget.modelGallery.title}",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text(
                    "ID: ${widget.modelGallery.id}",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
