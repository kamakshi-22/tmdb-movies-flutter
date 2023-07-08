import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart';
import 'package:tmdb_movies/models/movie_genres_model.dart';
import 'package:tmdb_movies/models/movie_popular_model.dart';
import 'package:tmdb_movies/utils/colors.dart';
import 'package:tmdb_movies/utils/textstyles.dart';
import 'package:tmdb_movies/widgets/card_detail.dart';
import 'package:tmdb_movies/widgets/play_button.dart';
import 'package:tmdb_movies/widgets/responsive.dart';
import 'package:tmdb_movies/widgets/section_title.dart';
import 'package:tmdb_movies/utils/layouts.dart';

class PopularSection extends StatelessWidget {
  final MovieGenresModel genresModel;
  final MoviePopularModel popularModel;
  const PopularSection(
      {super.key, required this.popularModel, required this.genresModel});

  @override
  Widget build(BuildContext context) {
    final popularMovies = popularModel.results;
    final genres = genresModel.genres;
    return Column(
      children: [
        const SectionTitle(title: "Popular"),
        Gap(AppLayout.getHeight(20)),
        MovieCarousel(popularMovies: popularMovies, genres: genres)
      ],
    );
  }
}

class MovieCarousel extends StatefulWidget {
  final List<Genre> genres;
  final List<Result> popularMovies;
  const MovieCarousel(
      {super.key, required this.popularMovies, required this.genres});

  @override
  State<MovieCarousel> createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
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
                itemCount: widget.popularMovies.length,
                itemBuilder: (context, index) {
                  var genreType;
                  for (var genre in widget.genres) {
                    if (widget.popularMovies[index].genreIds[0] == genre.id) {
                      genreType = genre.name;
                    }
                  }
                  return MovieCard(
                      popularMovie: widget.popularMovies[index],
                      genres: widget.genres,
                      genreType: genreType);
                })
            : Container(
                child: ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    itemCount: widget.popularMovies.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return Gap(AppLayout.getWidth(12));
                    },
                    itemBuilder: (context, index) {
                      var genreType;
                      for (var genre in widget.genres) {
                        if (widget.popularMovies[index].genreIds[0] ==
                            genre.id) {
                          genreType = genre.name;
                        }
                      }
                      return MovieCard(
                          popularMovie: widget.popularMovies[index],
                          genres: widget.genres,
                          genreType: genreType);
                    }),
              ));
  }
}

class MovieCard extends StatelessWidget {
  final List<Genre> genres;
  final Result popularMovie;
  final String genreType;
  const MovieCard(
      {super.key,
      required this.popularMovie,
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
                  image: NetworkImage(
                      dotenv.get('IMAGE_DETAIL_URL') + popularMovie.posterPath),
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
                    popularMovie.title,
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
