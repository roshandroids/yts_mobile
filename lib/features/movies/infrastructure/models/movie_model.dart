import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
abstract class MovieModel with _$MovieModel {
  const factory MovieModel({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'url') @Default('') String url,
    @JsonKey(name: 'imdb_code') @Default('') String imdbCode,
    @JsonKey(name: 'title') @Default('') String title,
    @JsonKey(name: 'title_english') @Default('') String titleEnglish,
    @JsonKey(name: 'title_long') @Default('') String titleLong,
    @JsonKey(name: 'slug') @Default('') String slug,
    @JsonKey(name: 'year') int? year,
    @JsonKey(name: 'rating') @Default(0.0) double rating,
    @JsonKey(name: 'runtime') @Default(0) int runtime,
    @JsonKey(name: 'genres') @Default(<String>[]) List<String> genres,
    @JsonKey(name: 'download_count') @Default(0) int downloadCount,
    @JsonKey(name: 'like_count') @Default(0) int likeCount,
    @JsonKey(name: 'summary') @Default('') String summary,
    @JsonKey(name: 'description_intro') @Default('') String descriptionIntro,
    @JsonKey(name: 'description_full') @Default('') String descriptionFull,
    @JsonKey(name: 'synopsis') @Default('') String synopsis,
    @JsonKey(name: 'yt_trailer_code') @Default('') String ytTrailerCode,
    @JsonKey(name: 'language') @Default('') String language,
    @JsonKey(name: 'mpa_rating') @Default('') String mpaRating,
    @JsonKey(name: 'background_image') @Default('') String backgroundImage,
    @JsonKey(name: 'background_image_original')
    @Default('')
        String backgroundImageOriginal,
    @JsonKey(name: 'small_cover_image') @Default('') String smallCoverImage,
    @JsonKey(name: 'medium_cover_image') @Default('') String mediumCoverImage,
    @JsonKey(name: 'large_cover_image') @Default('') String largeCoverImage,
    @JsonKey(name: 'state') @Default('') String state,
    @JsonKey(name: 'torrents') @Default(<Torrent>[]) List<Torrent> torrents,
    @JsonKey(name: 'date_uploaded') String? dateUploaded,
    @JsonKey(name: 'date_uploaded_unix') int? dateUploadedUnix,
  }) = _MovieModel;

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
}

@freezed
abstract class Torrent with _$Torrent {
  const factory Torrent({
    @JsonKey(name: 'url') @Default('') String url,
    @JsonKey(name: 'hash') @Default('') String hash,
    @JsonKey(name: 'quality') @Default('') String quality,
    @JsonKey(name: 'type') @Default('') String type,
    @JsonKey(name: 'seeds') @Default(0) int seeds,
    @JsonKey(name: 'peers') @Default(0) int peers,
    @JsonKey(name: 'size') @Default('') String size,
    @JsonKey(name: 'size_bytes') @Default(0) int sizeBytes,
    @JsonKey(name: 'date_uploaded') String? dateUploaded,
    @JsonKey(name: 'date_uploaded_unix') int? dateUploadedUnix,
  }) = _Torrent;

  factory Torrent.fromJson(Map<String, dynamic> json) =>
      _$TorrentFromJson(json);
}
