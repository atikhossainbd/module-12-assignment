import 'package:flutter/material.dart';
import 'package:photo_gallery_app/screens/details_screen.dart';
import '../model/model_gallery.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  List<ModelGallery> imageList = [];

  mySnackBar(message, context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'Reload',
          onPressed: () async {
            fetchImages();
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    fetchImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery App'),
        elevation: 2,
      ),
      body: _isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                return _listItem(imageList[index]);
              },
            ),
    );
  }

  Widget _listItem(ModelGallery images) {
    return ListTile(
      leading: Image.network(images.thumbnailUrl ?? ""),
      title: Text(images.title!),
      contentPadding: const EdgeInsets.all(7.0),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              modelGallery: images,
            ),
          ),
        );
      },
    );
  }

  Future<void> fetchImages() async {
    setState(() {
      _isLoading = true;
    });

    var response = await GalleryApi.fetchUsers();
    if (response.isNotEmpty) {
      imageList = response;
    } else {
      mySnackBar("Failed to fetch gallery data", context);
    }
    setState(() {
      _isLoading = false;
    });
  }
}
