import 'package:book_store/core/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCategorie extends StatelessWidget {
  const ShimmerCategorie({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[350]!,
          highlightColor: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.greyColor,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 110,
            width: 105,
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[350]!,
          highlightColor: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.greyColor,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 110,
            width: 105,
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[350]!,
          highlightColor: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.greyColor,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 110,
            width: 105,
          ),
        ),
      ],
    );
  }
}
