import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';

class WallpaperScreen extends StatelessWidget {
  final String imgUrl;
  WallpaperScreen({super.key, required this.imgUrl});
  //Global Key
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  //Method to download and set Wallpaper
  Future<void> setWallpaper(String imageUrl, BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text(
        'Downloading...',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    ));
    try {
      var imageId = await ImageDownloader.downloadImage(imgUrl);
      if (imageId == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
            'Failed to Download Image',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ));
        return;
      }

      //obtain image information
      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);

      // Log the file details for debugging
      print(
          'Downloaded file: $fileName at $path with size $size bytes and mime type $mimeType');

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'Downloaded Successfully',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ));
    } on PlatformException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error Occurred: $error',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imgUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.secondary.withOpacity(0.9),
                    Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context)
                        .colorScheme
                        .inverseSurface
                        .withOpacity(0.3),
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  setWallpaper(imgUrl, context);
                },
                splashColor: Colors.white.withOpacity(0.2),
                highlightColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Text(
                      'Set Wallpaper',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
