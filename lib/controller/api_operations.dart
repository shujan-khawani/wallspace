import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallspace/controller/api_key.dart';
import 'package:wallspace/model/photos_model.dart';

class ApiOperations {
  //Lists of Wallpapers
  static List<PhotosModel> trendingWallpapers = [];
  static List<PhotosModel> searchedWallpapers = [];
  static Future<List<PhotosModel>> getTrendingWallpapers() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated'),
        headers: {'Authorization': apiKey}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      trendingWallpapers.clear();
      photos.forEach(
        (element) {
          trendingWallpapers.add(PhotosModel.apiToApp(element));
        },
      );
    });
    return trendingWallpapers;
  }

  static Future<List<PhotosModel>> searchWallpaper(String query) async {
    await http.get(
        Uri.parse(
            'https://api.pexels.com/v1/search?query=$query&per_page=30&page=1'),
        headers: {'Authorization': apiKey}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      searchedWallpapers.clear();
      for (var element in photos) {
        searchedWallpapers.add(PhotosModel.apiToApp(element));
      }
    });
    return searchedWallpapers;
  }
}
