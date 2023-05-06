import 'package:flutter/cupertino.dart';
import '../models/category.dart';

class Categories extends ChangeNotifier {
  Category findById(String id) {
    return _availableCategories.firstWhere((category) => category.id == id);
  }

  List<Category> get availableCategories => [..._availableCategories];

  final List<Category> _availableCategories = [
    Category(id: '1', title: 'Tops'),
    Category(id: '2', title: 'Flat'),
    Category(id: '3', title: 'Huge'),
    Category(id: '4', title: 'Sleek'),
    Category(id: '5', title: 'Comfy'),
  ];
}
