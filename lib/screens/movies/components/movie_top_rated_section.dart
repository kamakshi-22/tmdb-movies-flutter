import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart';
import 'package:tmdb_movies/models/movie_genres_model.dart';
import 'package:tmdb_movies/models/movie_top_rated_model.dart';
import 'package:tmdb_movies/utils/colors.dart';
import 'package:tmdb_movies/utils/textstyles.dart';
import 'package:tmdb_movies/widgets/card_detail.dart';
import 'package:tmdb_movies/widgets/play_button.dart';
import 'package:tmdb_movies/widgets/responsive.dart';
import 'package:tmdb_movies/widgets/section_title.dart';
import 'package:tmdb_movies/utils/layouts.dart';

class TopRatedSection extends StatelessWidget {
  final MovieGenresModel genresModel;
  final MovieTopRatedModel topRatedModel;
  const TopRatedSection(
      {super.key, required this.topRatedModel, required this.genresModel});

  @override
  Widget build(BuildContext context) {
    final topRatedMovies = topRatedModel.results;
    final genres = genresModel.genres;
    return Column(
      children: [
        const SectionTitle(title: "Top Rated"),
        Gap(AppLayout.getHeight(20)),
        TopRatedMovieCarousel(topRatedMovies: topRatedMovies, genres: genres)
      ],
    );
  }
}

class TopRatedMovieCarousel extends StatefulWidget {
  final List<Genre> genres;
  final List<Result> topRatedMovies;
  const TopRatedMovieCarousel(
      {super.key, required this.topRatedMovies, required this.genres});

  @override
  State<TopRatedMovieCarousel> createState() => _TopRatedMovieCarouselState();
}

class _TopRatedMovieCarouselState extends State<TopRatedMovieCarousel> {
  final PageController _pageController = PageController(
      viewportFraction:
          0.8, // so that a small portion can be shown on left & right side
      initialPage: 1 //default movie poster
      );

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: AppLayout.getHeight(350),
        child: Responsive.isMobile(context)
            ? PageView.builder(
                controller: _pageController,
                itemCount: widget.topRatedMovies.length,
                itemBuilder: (context, index) {
                  var genreType;
                  for (var genre in widget.genres) {
                    if (widget.topRatedMovies[index].genreIds[0] == genre.id) {
                      genreType = genre.name;
                    }
                  }
                  return TopRatedMovieCard(
                      topRatedMovie: widget.topRatedMovies[index],
                      genres: widget.genres,
                      genreType: genreType);
                })
            : Container(
                child: ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    itemCount: widget.topRatedMovies.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return Gap(AppLayout.getWidth(12));
                    },
                    itemBuilder: (context, index) {
                      var genreType;
                      for (var genre in widget.genres) {
                        if (widget.topRatedMovies[index].genreIds[0] ==
                            genre.id) {
                          genreType = genre.name;
                        }
                      }
                      return TopRatedMovieCard(
                          topRatedMovie: widget.topRatedMovies[index],
                          genres: widget.genres,
                          genreType: genreType);
                    }),
              ));
  }
}

class TopRatedMovieCard extends StatelessWidget {
  final List<Genre> genres;
  final Result topRatedMovie;
  final String genreType;
  const TopRatedMovieCard(
      {super.key,
      required this.topRatedMovie,
      required this.genres,
      required this.genreType});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("tapped");
      },
      child: Stack(
        children: [
          Container(
            width:
                Responsive.isDesktop(context) ? AppLayout.getWidth(250) : null,
            margin: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(8)),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(AppLayout.getHeight(24))),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(dotenv.get('IMAGE_DETAIL_URL') +
                      topRatedMovie.posterPath),
                )),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MovieCardDetail(
                  detail: genreType,
                ),
                Gap(AppLayout.getHeight(10)),
                SizedBox(
                  width: AppLayout.getWidth(150),
                  child: Text(
                    topRatedMovie.title,
                    style: AppTextStyles.headlineSmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
          const Positioned(bottom: 30, right: 20, child: PlayButton()),
          Positioned(
              top: 20,
              right: 30,
              child: Container(
                height: AppLayout.getHeight(50),
                width: AppLayout.getWidth(50),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.backgroundColor,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        width: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                        ),
                      );
                    })),
              )),
        ],
      ),
    );
  }
}
