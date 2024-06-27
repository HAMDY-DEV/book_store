import 'package:book_store/core/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[350]!,
            highlightColor: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.greyColor,
                borderRadius: BorderRadius.circular(5),
              ),
              height: 30,
              width: 30,
            ),
          ),
          Column(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[350]!,
                highlightColor: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.greyColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 16,
                  width: 200,
                ),
              ),
              const Gap(5),
              Shimmer.fromColors(
                baseColor: Colors.grey[350]!,
                highlightColor: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.greyColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 16,
                  width: 180,
                ),
              ),
            ],
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[350]!,
            highlightColor: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.greyColor,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 40,
              width: 40,
            ),
          ),
        ],
      ),
    );
  }
}
