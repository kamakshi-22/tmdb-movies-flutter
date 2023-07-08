import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmdb_movies/models/movie_genres_model.dart';
import 'package:tmdb_movies/models/movie_now_playing_model.dart';
import 'package:tmdb_movies/models/movie_popular_model.dart';
import 'package:tmdb_movies/models/movie_top_rated_model.dart';
import 'package:tmdb_movies/screens/screens.dart';
import 'package:tmdb_movies/utils/colors.dart';
import 'package:tmdb_movies/utils/layouts.dart';
import 'package:tmdb_movies/utils/textstyles.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb_movies/widgets/responsive.dart';
import 'package:tmdb_movies/widgets/widgets.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {


  Future<List<dynamic>> fetchData() async {
    String genresUrl = dotenv.get('MOVIE_GENRES_URL');
    String nowPlayingUrl = dotenv.get('MOVIE_NOW_PLAYING_URL');
    String popularUrl = dotenv.get('MOVIE_POPULAR_URL');
    String topRatedUrl = dotenv.get('MOVIE_TOP_RATED_URL');
    String accessToken = dotenv.get('AUTH_TOKEN');

    try {
      final responses = await Future.wait([
        http.get(
          Uri.parse(genresUrl),
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
        http.get(
          Uri.parse(nowPlayingUrl),
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
        http.get(
          Uri.parse(popularUrl),
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
        http.get(
          Uri.parse(topRatedUrl),
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      ]);

      final List<dynamic> results = [];
      for (final response in responses) {
        if (response.statusCode == 200) {
          final jsonData = response.body;
          results.add(jsonData);
        } else {
          throw Exception('Request failed with status: ${response.statusCode}');
        }
      }

      return results;
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final List<dynamic> results = snapshot.data!;

              final genresJson = results[0];
              final genresModel = movieGenresModelFromJson(genresJson);

              final nowPlayingJson = results[1];
              final nowPlayingModel =
                  movieNowPlayingModelFromJson(nowPlayingJson);

              final popularJson = results[2];
              final popularModel = moviePopularModelFromJson(popularJson);

              final topRatedJson = results[3];
              print(topRatedJson);
              final topRatedModel = movieTopRatedModelFromJson(topRatedJson);

              return GlassmorphicBackground(
                  child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Responsive(
                        mobile: MoviesScreenMobile(
                          genresModel: genresModel,
                          nowPlayingModel: nowPlayingModel,
                          popularModel: popularModel,
                          topRatedModel: topRatedModel,
                        ),
                        desktop: MoviesScreenDesktop(
                            genresModel: genresModel,
                            nowPlayingModel: nowPlayingModel,
                            popularModel: popularModel,
                            topRatedModel: topRatedModel),
                      )));
            }
          }),
    );
  }
}

class MoviesScreenMobile extends StatelessWidget {
  final MovieGenresModel genresModel;
  final MovieNowPlayingModel nowPlayingModel;
  final MoviePopularModel popularModel;
  final MovieTopRatedModel topRatedModel;
  const MoviesScreenMobile(
      {super.key,
      required this.genresModel,
      required this.nowPlayingModel,
      required this.popularModel,
      required this.topRatedModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: AppLayout.getWidth(20),
          right: AppLayout.getWidth(20),
          top: AppLayout.getHeight(20)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "TMDB",
                style: AppTextStyles.displayMedium,
              ),
              Text(
                "MOVIES",
                style: AppTextStyles.displayMedium
                    .copyWith(color: AppColors.primaryColor),
              ),
            ],
          ),
          Gap(AppLayout.getHeight(20)),
          NowPlayingSection(
            nowPlayingModel: nowPlayingModel,
            genresModel: genresModel,
          ),
          Gap(AppLayout.getHeight(10)),
          MovieGenresSection(genreModel: genresModel),
          Gap(AppLayout.getHeight(20)),
          PopularSection(popularModel: popularModel, genresModel: genresModel),
          Gap(AppLayout.getHeight(20)),
          TopRatedSection(
              topRatedModel: topRatedModel, genresModel: genresModel),
        ],
      ),
    );
  }
}

class MoviesScreenDesktop extends StatelessWidget {
  final MovieGenresModel genresModel;
  final MovieNowPlayingModel nowPlayingModel;
  final MoviePopularModel popularModel;
  final MovieTopRatedModel topRatedModel;
  const MoviesScreenDesktop(
      {super.key,
      required this.genresModel,
      required this.nowPlayingModel,
      required this.popularModel,
      required this.topRatedModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: AppLayout.getWidth(20),
              vertical: AppLayout.getHeight(10)),
          child: Row(
            children: [
              Text(
                "TMDB",
                style: AppTextStyles.displayLarge,
              ),
              Text(
                "MOVIES",
                style: AppTextStyles.displayLarge
                    .copyWith(color: AppColors.primaryColor),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: AppLayout.getWidth(20),
              vertical: AppLayout.getHeight(20)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppLayout.getWidth(10),
                    vertical: AppLayout.getHeight(10),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppLayout.getWidth(24),
                      ),
                      color: AppColors.backgroundColor.withOpacity(0.35)),
                  width: AppLayout.getScreenWidth() * 0.2,
                  child: MovieGenresSection(genreModel: genresModel)),
              Gap(AppLayout.getWidth(50)),
              Expanded(
                child: Column(
                  children: [
                    NowPlayingSection(
                      nowPlayingModel: nowPlayingModel,
                      genresModel: genresModel,
                    ),
                    Gap(AppLayout.getHeight(10)),
                    Gap(AppLayout.getHeight(24)),
                    PopularSection(
                        popularModel: popularModel, genresModel: genresModel),
                    Gap(AppLayout.getHeight(24)),
                    TopRatedSection(
                        topRatedModel: topRatedModel, genresModel: genresModel),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
