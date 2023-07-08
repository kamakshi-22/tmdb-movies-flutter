import 'package:flutter/material.dart';
import 'package:tmdb_movies/utils/colors.dart';
import 'package:tmdb_movies/utils/textstyles.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyles.headlineMedium,
        ),
        const Spacer(),
        Text(
          "See All",
          style:
              AppTextStyles.bodyMedium.copyWith(color: AppColors.primaryColor),
        ),
      ],
    );
  }
}
