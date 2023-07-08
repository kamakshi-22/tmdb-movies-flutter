import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tmdb_movies/models/movie_genres_model.dart';
import 'package:tmdb_movies/models/movie_now_playing_model.dart';
import 'package:tmdb_movies/screens/screens.dart';
import 'package:tmdb_movies/utils/colors.dart';
import 'package:tmdb_movies/utils/layouts.dart';
import 'package:tmdb_movies/utils/textstyles.dart';
import 'package:tmdb_movies/widgets/play_button.dart';
import 'package:tmdb_movies/widgets/responsive.dart';
import 'package:tmdb_movies/widgets/section_title.dart';

class NowPlayingSection extends StatelessWidget {
  final MovieGenresModel genresModel;
  final MovieNowPlayingModel nowPlayingModel;
  const NowPlayingSection({
    super.key,
    required this.nowPlayingModel,
    required this.genresModel,
  });

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = nowPlayingModel.results;
    return Column(
      children: [
        const SectionTitle(title: "Now Playing"),
        Gap(AppLayout.getHeight(20)),
        SizedBox(
            height: Responsive.isMobile(context)
                ? AppLayout.getHeight(200)
                : AppLayout.getScreenHeight() * 0.5,
            width: AppLayout.getScreenWidth(),
            child: ListView.separated(
                physics: const ClampingScrollPhysics(),
                itemCount: nowPlayingMovies.length,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return Gap(AppLayout.getWidth(12));
                },
                itemBuilder: (context, index) {
                  return NowPlayingMovieCard(
                      nowPlayingMovie: nowPlayingMovies[index]);
                })),
      ],
    );
  }
}

class NowPlayingMovieCard extends StatelessWidget {
  final Result nowPlayingMovie;
  const NowPlayingMovieCard({
    super.key,
    required this.nowPlayingMovie,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MovieDetailsScreen(nowPlayingMovie: nowPlayingMovie)));
      },
      child: Stack(children: [
        Container(
          width: Responsive.isMobile(context)
              ? AppLayout.getScreenWidth() * 0.8
              : AppLayout.getScreenWidth() * 0.6,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(AppLayout.getHeight(24))),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(dotenv.get('IMAGE_DETAIL_URL') +
                    nowPlayingMovie.posterPath),
              )),
        ),
        Positioned(
            left: AppLayout.getWidth(20),
            bottom: AppLayout.getWidth(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: AppLayout.getScreenWidth() * 0.6,
                  child: Text(
                    nowPlayingMovie.title,
                    style: AppTextStyles.displaySmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Gap(AppLayout.getHeight(10)),
                const PlayButton(),
              ],
            ))
      ]),
    );
  }
}
