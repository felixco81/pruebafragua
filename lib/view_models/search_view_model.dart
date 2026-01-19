import 'package:flutter/material.dart';
import '../services/unsplash_service.dart';
import '../models/unsplass_foto.dart';

class SearchViewModel extends ChangeNotifier {
  final unsplashService = UnsplashService();
  late List<UnsplashPhoto> _imgaes = [];
  bool loading = false;
  List<UnsplashPhoto> get images => List.unmodifiable(_imgaes);

  Future<void> fetchPhotos(String query) async {
   // print("QUERY");
  //  print("QUERY:" + query);
    try {
       _imgaes = [];
      loading = true;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 2)); // simular tiempo de carga
      List<UnsplashPhoto> photos = await unsplashService.searchPhotos(
        query: query,
      );
      _imgaes = photos;
      loading = false;
    } catch (e) {
      _imgaes = [];
      loading = false;
      print('Error: $e');
      
    }
  }

  Future<void> Search(String query) async {
    await fetchPhotos(query);
    notifyListeners();
  }
}
