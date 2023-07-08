import 'package:flutter/material.dart';
import 'package:tmdb_movies/utils/colors.dart';
import 'package:tmdb_movies/utils/layouts.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColor,
      ),
      child: Icon(
        Icons.play_arrow_rounded,
        color: AppColors.textColor,
        size: AppLayout.getHeight(40),
      ),
    );
  }
}