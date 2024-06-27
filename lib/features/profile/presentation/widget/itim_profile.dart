import 'package:book_store/core/util/colors.dart';
import 'package:book_store/core/util/text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ItimProfile extends StatelessWidget {
  const ItimProfile({
    super.key,
    required this.text,
    required this.icon,
    required this.title,
  });

  final String title;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: getBodyStyle(context,
                fontSize: 13, color: AppColors.primaryColor)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primaryColor),
            const Gap(10),
            Text(
              text,
              style: getBodyStyle(context,
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const Gap(25),
      ],
    );
  }
}
