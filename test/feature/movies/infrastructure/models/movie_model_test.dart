import 'package:flutter_test/flutter_test.dart';
import 'package:yts_mobile/feature/movies/infrastructure/infrastructure.dart';

void main() {
  const rawMovieExampleData = <String, dynamic>{
    'id': 47785,
    'url': 'https://yts.mx/movies/the-bargain-2021',
    'imdb_code': 'tt15488512',
    'title': 'The Bargain',
    'title_english': 'The Bargain',
    'title_long': 'The Bargain (2021)',
    'slug': 'the-bargain-2021',
    'year': 2021,
    'rating': 6.0,
    'runtime': 118,
    'genres': ['Crime'],
    'download_count': 249542,
    'like_count': 284,
    'description_intro':
        'Liu wants to sell his unprofitable travel agency business.',
    'summary': 'Liu wants to sell his unprofitable travel agency business.',
    'description_full':
        'Liu wants to sell his unprofitable travel agency business.',
    'synopsis': 'Liu wants to sell his unprofitable travel agency business.',
    'yt_trailer_code': 'VrT3G2B94zw',
    'language': 'zh',
    'mpa_rating': '',
    'background_image':
        'https://yts.mx/assets/images/movies/the_bargain_2021/background.jpg',
    'background_image_original':
        'https://yts.mx/assets/images/movies/the_bargain_2021/background.jpg',
    'small_cover_image':
        'https://yts.mx/assets/images/movies/the_bargain_2021/small-cover.jpg',
    'medium_cover_image':
        'https://yts.mx/assets/images/movies/the_bargain_2021/medium-cover.jpg',
    'large_cover_image':
        'https://yts.mx/assets/images/movies/the_bargain_2021/large-cover.jpg',
    'state': 'ok',
    'torrents': <Map<String, dynamic>>[],
    'date_uploaded': '2022-12-24 01:27:50',
    'date_uploaded_unix': 1671841670
  };
  const torrentRawExampleData = {
    'url':
        'https://yts.mx/torrent/download/1736573C6429327F443DE0B168F573EE2765EA2E',
    'hash': '1736573C6429327F443DE0B168F573EE2765EA2E',
    'quality': '720p',
    'type': 'web',
    'seeds': 0,
    'peers': 0,
    'size': '1.06 GB',
    'size_bytes': 1138166333,
    'date_uploaded': '2022-12-24 01:27:50',
    'date_uploaded_unix': 1671841670
  };

  const movieExampleData = MovieModel(
    id: 47785,
    url: 'https://yts.mx/movies/the-bargain-2021',
    imdbCode: 'tt15488512',
    title: 'The Bargain',
    titleEnglish: 'The Bargain',
    titleLong: 'The Bargain (2021)',
    slug: 'the-bargain-2021',
    year: 2021,
    rating: 6,
    runtime: 118,
    genres: ['Crime'],
    downloadCount: 249542,
    likeCount: 284,
    descriptionIntro:
        'Liu wants to sell his unprofitable travel agency business.',
    summary: 'Liu wants to sell his unprofitable travel agency business.',
    descriptionFull:
        'Liu wants to sell his unprofitable travel agency business.',
    synopsis: 'Liu wants to sell his unprofitable travel agency business.',
    ytTrailerCode: 'VrT3G2B94zw',
    language: 'zh',
    mpaRating: '',
    backgroundImage:
        'https://yts.mx/assets/images/movies/the_bargain_2021/background.jpg',
    backgroundImageOriginal:
        'https://yts.mx/assets/images/movies/the_bargain_2021/background.jpg',
    smallCoverImage:
        'https://yts.mx/assets/images/movies/the_bargain_2021/small-cover.jpg',
    mediumCoverImage:
        'https://yts.mx/assets/images/movies/the_bargain_2021/medium-cover.jpg',
    largeCoverImage:
        'https://yts.mx/assets/images/movies/the_bargain_2021/large-cover.jpg',
    state: 'ok',
    torrents: [],
    dateUploaded: '2022-12-24 01:27:50',
    dateUploadedUnix: 1671841670,
  );
  const torrentExampleData = Torrent(
    url:
        'https://yts.mx/torrent/download/1736573C6429327F443DE0B168F573EE2765EA2E',
    hash: '1736573C6429327F443DE0B168F573EE2765EA2E',
    quality: '720p',
    type: 'web',
    seeds: 0,
    peers: 0,
    size: '1.06 GB',
    sizeBytes: 1138166333,
    dateUploaded: '2022-12-24 01:27:50',
    dateUploadedUnix: 1671841670,
  );
  group(
    'Test for movie model response',
    () {
      test(
        'can parse data to  movie model fromJson',
        () async {
          expect(
            MovieModel.fromJson(rawMovieExampleData),
            equals(movieExampleData),
          );
        },
      );
      test(
        'can parse data to  torrent model fromJson',
        () async {
          expect(
            Torrent.fromJson(torrentRawExampleData),
            equals(torrentExampleData),
          );
        },
      );
      // test('can convert movie data model toJson', () {
      //   expect(movieExampleData.toJson(), rawMovieExampleData);
      // });
      test('can convert torrent data model toJson', () {
        expect(torrentExampleData.toJson(), torrentRawExampleData);
      });
    },
  );
}
