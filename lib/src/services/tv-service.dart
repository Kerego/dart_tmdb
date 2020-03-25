part of 'tmdb-service.dart';

class TvService extends _CommonService {
  TvService(String apiKey) : super(apiKey);

  Future<PagedResult<TvBase>> search(String query, {int page}) {
    var settings = TvSearchSettings(query: query);
    return advancedSearch(settings, page: page);
  }

  Future<PagedResult<TvBase>> advancedSearch(TvSearchSettings settings,
      {int page}) {
    assert(settings.query != null && settings.query.isNotEmpty);
    return _fetchPagedResult<TvBase>(
      "3/search/tv",
      settings ?? const TvSearchSettings(),
      (map, assetResolver) => TvBase.fromJson(map, assetResolver),
      page ?? 1,
    );
  }

  Future<PagedResult<TvBase>> discover(
          {TvDiscoverSettings settings, int page}) =>
      _fetchPagedResult<TvBase>(
        "3/discover/tv",
        settings ?? const TvDiscoverSettings(),
        (map, assetResolver) => TvBase.fromJson(map, assetResolver),
        page ?? 1,
      );

  Future<PagedResult<TvBase>> getTopRated(
          {TvSearchSettings settings, int page}) =>
      _fetchPagedResult<TvBase>(
        "3/tv/top_rated",
        settings ?? const TvSearchSettings(),
        (map, assetResolver) => TvBase.fromJson(map, assetResolver),
        page ?? 1,
      );

  Future<PagedResult<TvBase>> getPopular(
          {TvSearchSettings settings, int page}) =>
      _fetchPagedResult<TvBase>(
        "3/tv/popular",
        settings ?? const TvSearchSettings(),
        (map, assetResolver) => TvBase.fromJson(map, assetResolver),
        page ?? 1,
      );

  Future<PagedResult<TvBase>> getAiringToday(
          {TvSearchSettings settings, int page}) =>
      _fetchPagedResult<TvBase>(
        "3/tv/airing_today",
        settings ?? const TvSearchSettings(),
        (map, assetResolver) => TvBase.fromJson(map, assetResolver),
        page ?? 1,
      );

  Future<PagedResult<TvBase>> getOnTheAir(
          {TvSearchSettings settings, int page}) =>
      _fetchPagedResult<TvBase>(
        "3/tv/on_the_air",
        settings ?? const TvSearchSettings(),
        (map, assetResolver) => TvBase.fromJson(map, assetResolver),
        page ?? 1,
      );

  Future<TvShow> getLatest({String language, QualitySettings qualitySettings}) {
    var queryParams = {
      "api_key": _apiKey,
      "language": language ?? "en-US",
    };

    return _get<TvShow>(
      "3/tv/latest",
      queryParams,
      qualitySettings ?? const QualitySettings(),
      (map, assetResolver) => TvShow.fromJson(map, assetResolver),
    );
  }

  Future<List<Video>> getVideos(
    int tvId, {
    String language,
  }) {
    assert(tvId != null, "ID can't be null");
    var queryParams = {
      "api_key": _apiKey,
      "language": language ?? "en-US",
    };

    return _get<List<Video>>(
      "3/tv/$tvId/videos",
      queryParams,
      null,
      (map, assetResolver) => Video.listFromJson(map["results"]),
    );
  }

  Future<TvShow> getDetails(
    int tvId, {
    String language,
    List<String> imageLanguages,
    AppendSettings appendSettings,
    QualitySettings qualitySettings,
  }) {
    assert(tvId != null, "ID can't be null");
    var queryParams = {
      "api_key": _apiKey,
      "language": language ?? "en-US",
      "include_image_language": (imageLanguages ?? const ["en"]).join(","),
      "append_to_response":
          (appendSettings ?? const AppendSettings()).toString()
    };

    return _get<TvShow>(
      "3/tv/$tvId",
      queryParams,
      qualitySettings ?? const QualitySettings(),
      (map, assetResolver) => TvShow.fromJson(map, assetResolver),
    );
  }

  Future<List<Video>> getSeasonVideos(
    int tvId, {
    int seasonNumber,
    String language,
  }) {
    assert(tvId != null, "ID can't be null");
    var queryParams = {
      "api_key": _apiKey,
      "language": language ?? "en-US",
    };

    return _get<List<Video>>(
      "3/tv/$tvId/season/${seasonNumber ?? 0}/videos",
      queryParams,
      null,
      (map, assetResolver) => Video.listFromJson(map["results"]),
    );
  }

  Future<TvSeason> getSeasonDetails(
    int tvId, {
    int seasonNumber,
    String language,
    List<String> imageLanguages,
    AppendSettings appendSettings,
    QualitySettings qualitySettings,
  }) {
    assert(tvId != null, "TvId can't be null");
    var queryParams = {
      "api_key": _apiKey,
      "language": language ?? "en-US",
      "include_image_language": (imageLanguages ?? const ["en"]).join(","),
      "append_to_response":
          (appendSettings ?? const AppendSettings()).toString()
    };

    return _get<TvSeason>(
      "3/tv/$tvId/season/${seasonNumber ?? 0}",
      queryParams,
      qualitySettings ?? const QualitySettings(),
      (map, assetResolver) => TvSeason.fromJson(map, assetResolver),
    );
  }

  Future<List<Video>> getEpisodeVideos(
    int tvId, {
    int seasonNumber,
    int episodeNumber,
    String language,
  }) {
    assert(tvId != null, "ID can't be null");
    var queryParams = {
      "api_key": _apiKey,
      "language": language ?? "en-US",
    };

    return _get<List<Video>>(
      "3/tv/$tvId/season/${seasonNumber ?? 0}/episode/${episodeNumber ?? 1}/videos",
      queryParams,
      null,
      (map, assetResolver) => Video.listFromJson(map["results"]),
    );
  }

  Future<TvEpisode> getEpisodeDetails(
    int tvId, {
    int seasonNumber,
    int episodeNumber,
    String language,
    List<String> imageLanguages,
    AppendSettings appendSettings,
    QualitySettings qualitySettings,
  }) {
    assert(tvId != null, "TvId can't be null");
    var queryParams = {
      "api_key": _apiKey,
      "language": language ?? "en-US",
      "include_image_language": (imageLanguages ?? const ["en"]).join(","),
      "append_to_response":
          (appendSettings ?? const AppendSettings()).toString()
    };

    return _get<TvEpisode>(
      "3/tv/$tvId/season/${seasonNumber ?? 0}/episode/${episodeNumber ?? 1}",
      queryParams,
      qualitySettings ?? const QualitySettings(),
      (map, assetResolver) => TvEpisode.fromJson(map, assetResolver),
    );
  }
}
