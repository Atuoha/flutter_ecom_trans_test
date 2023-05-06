import 'package:flutter/cupertino.dart';
import '../models/review.dart';
import '../resources/assets_manager.dart';

class Reviews extends ChangeNotifier {
  Review findById(String id) {
    return _availableReviews.firstWhere((store) => store.id == id);
  }

  List<Review> get availableReviews => [..._availableReviews];

  final List<Review> _availableReviews = [
    Review(
      id: '1',
      username: 'John',
      imgUrl: AssetManager.user1,
      review: 'Nice product. I really love another one',
      rating: 4.2,
    ),
    Review(
      id: '2',
      username: 'Philips',
      imgUrl: AssetManager.user2,
      review: 'I really love this sneakers',
      rating: 5.0,
    ),
    Review(
      id: '3',
      username: 'Enoch',
      imgUrl: AssetManager.user3,
      review: 'This one is really cool!',
      rating: 3.2,
    ),
  ];
}
