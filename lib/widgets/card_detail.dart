import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:tmdb_movies/utils/colors.dart';
import 'package:tmdb_movies/utils/layouts.dart';
import 'package:tmdb_movies/utils/textstyles.dart';

class MovieCardDetail extends StatelessWidget {
  final String detail;
  bool? leadingIcon;

  MovieCardDetail({super.key, required this.detail, this.leadingIcon = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppLayout.getWidth(9),
        vertical: AppLayout.getHeight(2),
      ),
      decoration: BoxDecoration(
          color: AppColors.accentColor,
          border: Border.all(color: AppColors.accentColor),
          borderRadius: BorderRadius.circular(AppLayout.getHeight(10))),
      child: Row(
        children: [
          if (leadingIcon == true)
            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.yellow.shade800,
                  size: 20,
                ),
                Gap(AppLayout.getWidth(4))
              ],
            ),
          Text(
            detail,
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}
