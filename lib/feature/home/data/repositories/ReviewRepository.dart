import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ta9sela/feature/home/data/models/ReviewModel.dart';


class ReviewRepository {
  final _reviews = FirebaseFirestore.instance.collection('reviews');

  Future<void> addReview(ReviewModel review) async {
    await _reviews.add(review.toJson());
  }

  Stream<List<ReviewModel>> getDriverReviews(String driverId) {
    return _reviews
        .where('driverId', isEqualTo: driverId)
        .snapshots()
        .map((e) => e.docs
            .map((d) => ReviewModel.fromJson(d.data(), d.id))
            .toList());
  }
}
