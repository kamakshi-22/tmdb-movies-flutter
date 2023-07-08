import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:tmdb_movies/utils/colors.dart';
import 'package:tmdb_movies/utils/layouts.dart';
import 'package:tmdb_movies/utils/textstyles.dart';
import 'package:tmdb_movies/widgets/card_detail.dart';
import 'package:tmdb_movies/widgets/widgets.dart';
import '../models/movie_now_playing_model.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Result nowPlayingMovie;
  const MovieDetailsScreen({super.key, required this.nowPlayingMovie});

  @override
  Widget build(BuildContext context) {
    String voteAverage = nowPlayingMovie.voteAverage.toString();
    DateTime releaseDate = nowPlayingMovie.releaseDate;
    String formattedDate = DateFormat('MMMM yyyy').format(releaseDate);

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.white,
          iconSize: 30,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: AppLayout.getScreenHeight() * 0.7,
              width: AppLayout.getScreenWidth(),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(dotenv.get('IMAGE_DETAIL_URL') +
                            nowPlayingMovie.posterPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black, Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            if (nowPlayingMovie.adult == true)
                              Row(
                                children: [
                                  MovieCardDetail(detail: "18+"),
                                  Gap(AppLayout.getWidth(8)),
                                ],
                              ),
                            MovieCardDetail(
                                detail: voteAverage, leadingIcon: true),
                            Gap(AppLayout.getWidth(8)),
                            MovieCardDetail(detail: formattedDate),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.circlePlus,
                            color: Colors.white,
                          ),
                          Gap(AppLayout.getWidth(8)),
                          const FaIcon(
                            FontAwesomeIcons.shareNodes,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ],
                  ),
                  Gap(AppLayout.getHeight(24)),
                  Text(
                    nowPlayingMovie.title,
                    style: AppTextStyles.displaySmall,
                  ),
                  Gap(AppLayout.getHeight(12)),
                  Text(
                    nowPlayingMovie.overview,
                    style: AppTextStyles.bodyMedium,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
