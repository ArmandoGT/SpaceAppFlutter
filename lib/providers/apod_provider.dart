import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/apod_model.dart';
import '../services/nasa_service.dart';

class ApodProvider with ChangeNotifier {
  final NasaService _service = NasaService();

  ApodModel? currentApod;
  bool isLoading = false;
  String errorMessage = '';

  List<ApodModel> _favorites = [];
  List<ApodModel> get favorites => _favorites;

  ApodProvider() {
    loadFavorites();
  }

  Future<void> fetchApod(String? date) async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      currentApod = await _service.getApod(date: date);
    } catch (e) {
      errorMessage = 'Falha ao conectar com a NASA. Tente novamente.';
      currentApod = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // --- Lógica Favoritos ---

  bool isFavorite(String date) {
    return _favorites.any((item) => item.date == date);
  }

  void toggleFavorite() {
    if (currentApod == null) return;

    if (isFavorite(currentApod!.date)) {
      _favorites.removeWhere((item) => item.date == currentApod!.date);
    } else {
      _favorites.add(currentApod!);
    }
    _saveToPrefs();
    notifyListeners();
  }

  void removeFavorite(ApodModel apod) {
    _favorites.removeWhere((item) => item.date == apod.date);
    _saveToPrefs();
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = ApodModel.encode(_favorites);
    await prefs.setString('favorites_list', encodedData);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? musicString = prefs.getString('favorites_list');
    if (musicString != null) {
      _favorites = ApodModel.decode(musicString);
      notifyListeners();
    }
  }
}
