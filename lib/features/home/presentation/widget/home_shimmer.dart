import 'package:book_store/core/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[350]!,
              highlightColor: Colors.white,
              child: Container(
                height: 160,
                width: 115,
                decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
            const Gap(5),
            Shimmer.fromColors(
              baseColor: Colors.grey[350]!,
              highlightColor: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(3),
                ),
                height: 13,
                width: 100,
              ),
            ),
            const Gap(5),
            Shimmer.fromColors(
              baseColor: Colors.grey[350]!,
              highlightColor: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(3),
                ),
                height: 13,
                width: 80,
              ),
            ),
            const Gap(5),
            Shimmer.fromColors(
              baseColor: Colors.grey[350]!,
              highlightColor: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(3),
                ),
                height: 13,
                width: 60,
              ),
            ),
          ],
        ),
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[350]!,
              highlightColor: Colors.white,
              child: Container(
                height: 160,
                width: 115,
                decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
            const Gap(5),
            Shimmer.fromColors(
              baseColor: Colors.grey[350]!,
              highlightColor: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(3),
                ),
                height: 13,
                width: 100,
              ),
            ),
            const Gap(5),
            Shimmer.fromColors(
              baseColor: Colors.grey[350]!,
              highlightColor: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(3),
                ),
                height: 13,
                width: 80,
              ),
            ),
            const Gap(5),
            Shimmer.fromColors(
              baseColor: Colors.grey[350]!,
              highlightColor: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(3),
                ),
                height: 13,
                width: 60,
              ),
            ),
          ],
        ),
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[350]!,
              highlightColor: Colors.white,
              child: Container(
                height: 160,
                width: 115,
                decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
            const Gap(5),
            Shimmer.fromColors(
              baseColor: Colors.grey[350]!,
              highlightColor: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(3),
                ),
                height: 13,
                width: 100,
              ),
            ),
            const Gap(5),
            Shimmer.fromColors(
              baseColor: Colors.grey[350]!,
              highlightColor: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(3),
                ),
                height: 13,
                width: 80,
              ),
            ),
            const Gap(5),
            Shimmer.fromColors(
              baseColor: Colors.grey[350]!,
              highlightColor: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(3),
                ),
                height: 13,
                width: 60,
              ),
            ),
          ],
        ),
      
      ],
    );
  }
}
