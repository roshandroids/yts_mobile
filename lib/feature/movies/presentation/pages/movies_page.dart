import 'package:flutter/material.dart';
import 'package:yts_mobile/feature/movies/movies.dart';

class RandomPhotosPage extends StatelessWidget {
  const RandomPhotosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const MoviesList(),
    );
  }
}
