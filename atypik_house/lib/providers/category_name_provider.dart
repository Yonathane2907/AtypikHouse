import 'package:flutter/foundation.dart';
import '../services/categories_service.dart';

class CategoryProvider extends ChangeNotifier {
  List<String> _categories = [];

  List<String> get categories => _categories;

  Future<void> fetchCategories() async {
    try {
      _categories = await CategoriesService().fetchCategories();
      notifyListeners();
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }
}
