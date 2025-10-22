import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildRatingStars(double rate) {
  int fullStars = rate.floor();
  bool halfStar = (rate - fullStars) >= 0.5;
  return Row(
    children: List.generate(5, (index) {
      if (index < fullStars) {
        return const Icon(Icons.star, color: Colors.amber, size: 20);
      } else if (index == fullStars && halfStar) {
        return const Icon(Icons.star_half, color: Colors.amber, size: 20);
      } else {
        return const Icon(Icons.star_border, color: Colors.amber, size: 20);
      }
    }),
  );
}