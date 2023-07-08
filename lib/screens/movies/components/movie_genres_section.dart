import 'package:flutter/material.dart';
import 'package:tmdb_movies/models/movie_genres_model.dart';
import 'package:tmdb_movies/utils/layouts.dart';
import 'package:tmdb_movies/utils/textstyles.dart';
import 'package:tmdb_movies/widgets/responsive.dart';

class MovieGenresSection extends StatefulWidget {
  final MovieGenresModel genreModel;
  const MovieGenresSection({super.key, required this.genreModel});

  @override
  State<MovieGenresSection> createState() => _MovieGenresSectionState();
}

class _MovieGenresSectionState extends State<MovieGenresSection> {
  @override
  Widget build(BuildContext context) {
    final genres = widget.genreModel.genres;
    return Container(
      padding: Responsive.isDesktop(context)
          ? EdgeInsets.symmetric(vertical: AppLayout.getHeight(16))
          : null,
      height: Responsive.isMobile(context)
          ? AppLayout.getHeight(40)
          : AppLayout.getScreenHeight() * 1.2,
      child: ListView.builder(
          padding:
              Responsive.isDesktop(context) ? const EdgeInsets.all(0) : null,
          physics: Responsive.isMobile(context)
              ? ClampingScrollPhysics()
              : NeverScrollableScrollPhysics(),
          scrollDirection:
              Responsive.isMobile(context) ? Axis.horizontal : Axis.vertical,
          itemCount: genres.length,
          itemBuilder: (context, index) {
            return GenreCard(genre: genres[index]);
          }),
    );
  }
}

class GenreCard extends StatelessWidget {
  final Genre genre;
  const GenreCard({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Responsive.isMobile(context)
          ? EdgeInsets.only(left: AppLayout.getWidth(6))
          : EdgeInsets.only(bottom: AppLayout.getWidth(6)),
      padding: EdgeInsets.symmetric(
        horizontal: AppLayout.getWidth(9),
        vertical: AppLayout.getHeight(8),
      ),
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.white70,
              width: Responsive.isDesktop(context) ? 1.5 : 1),
          borderRadius: BorderRadius.circular(AppLayout.getHeight(20))),
      child: Text(
        genre.name,
        style: AppTextStyles.labelLarge,
      ),
    );
  }
}
