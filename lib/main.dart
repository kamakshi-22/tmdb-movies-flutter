import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tmdb_movies/models/movie_genres_model.dart';
import 'package:tmdb_movies/screens/movies/movies_screen.dart';
import 'package:tmdb_movies/utils/theme.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  await dotenv.load();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TMDB Movies App',
        theme: AppTheme.lightTheme,
        scrollBehavior: MyCustomScrollBehavior(),
        home: MoviesScreen());
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

/* class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  Future<List<dynamic>> fetchData() async {
    String genresUrl = dotenv.get('GENRES_URL');
    String nowPlayingUrl = dotenv.get('NOW_PLAYING_URL');

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
              final nowPlayingJson = results[1];
              print(nowPlayingJson);

              final genresModel = genresModelFromJson(genresJson);
              final genres = genresModel.genres;
              // final nowPlayingMovies = List<Movie>.from(json.decode(nowPlayingJson).map((movieJson) => Movie.fromJson(movieJson)));
              return ListView.builder(
                  itemCount: genres.length,
                  itemBuilder: ((context, index) {
                    final genre = genres[index];
                    return ListTile(
                      title: Text('ID: ${genre.id}'),
                      subtitle: Text(genre.name),
                    );
                  }));
            }
          }),
    );
  }
}
 */