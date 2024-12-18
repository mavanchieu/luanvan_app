import 'package:flutter/material.dart';
// Đảm bảo bạn import đúng đường dẫn đến widget StarRating

import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final ValueChanged<double> onRatingChanged;

  const StarRating({
    super.key,
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

// class Star extends StatelessWidget {
//   const Star({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Column(
//       children: [
//         RatingDemo(),
//       ],
//     );
//   }
// }

class RatingDemo extends StatefulWidget {
  final double rate;
  const RatingDemo({
    super.key,
    required this.rate,
  });

  @override
  _RatingDemoState createState() => _RatingDemoState();
}

class _RatingDemoState extends State<RatingDemo> {
  double _rating = 0.0;

  void _onRatingChanged(double rating) {
    setState(() {
      _rating = widget.rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        StarRatingEval(
          starCount: 5,
          rating: widget.rate,
        ),
        // Text(
        //   '${widget.rate} sao',
        //   style: const TextStyle(
        //     fontSize: 18,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
      ],
    );
  }
}

class StarRatingEval extends StatelessWidget {
  final int starCount;
  final double rating;

  const StarRatingEval({
    super.key,
    required this.starCount,
    required this.rating,
  });

  Widget buildStar(int index) {
    final double starValue = index + 1;
    final bool isFullStar = starValue <= rating.floor();
    final bool isHalfStar = starValue - 0.5 <= rating && rating < starValue;

    return Icon(
      isFullStar
          ? Icons.star
          : (isHalfStar ? Icons.star_half : Icons.star_border),
      color: Colors.amber,
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
