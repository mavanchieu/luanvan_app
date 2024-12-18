import 'package:flutter/material.dart';
// Đảm bảo bạn import đúng đường dẫn đến widget StarRating

import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final ValueChanged<double> onRatingChanged;

  const StarRating({
    required this.starCount,
    required this.rating,
    required this.onRatingChanged,
  });

  Widget buildStar(int index) {
    final double starValue = index + 1;
    final bool isFullStar = starValue <= rating.floor();
    final bool isHalfStar = starValue - 0.5 <= rating && rating < starValue;

    return IconButton(
      icon: Icon(
        isFullStar
            ? Icons.star
            : (isHalfStar ? Icons.star_half : Icons.star_border),
        color: Colors.amber,
      ),
      onPressed: () => onRatingChanged(starValue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, buildStar),
    );
  }
}

// class StarRated extends StatelessWidget {
//   const StarRated({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Column(
//       children: [
//         RatingDemo(),
//       ],
//     );
//   }
// }

// class RatingDemo extends StatefulWidget {
//   const RatingDemo({super.key});

//   @override
//   _RatingDemoState createState() => _RatingDemoState();
// }

// class _RatingDemoState extends State<RatingDemo> {
//   final double _rating = 4.9;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         StarRating(
//           starCount: 5,
//           rating: _rating,
//           onRatingChanged: _onRatingChanged,
//         ),
//       ],
//     );
//   }
// }
