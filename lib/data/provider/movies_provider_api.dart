import 'package:dio/dio.dart';
import 'package:gdg_depok_2019_beginner/data/entity/list_movie_dto.dart';
import 'package:gdg_depok_2019_beginner/domain/repository/movie_repository.dart';


class MoviesProviderApi implements MovieInterface {
  final Dio _dio;
  final String secretKey = "b77a9c9af1b4434dcbbacdde72879e7c";
  final String _urlPopularMovies = "/movie/popular";

  MoviesProviderApi()
  : _dio = initDio();

  Future<ListMoviesDto> getListMovies(int page) async {
    try {
      Response response = await _dio.get(_urlPopularMovies, queryParameters: {"api_key": secretKey, "language": "en-US", "page": page});
      return ListMoviesDto.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ListMoviesDto.withError(error.toString());
    }
  }
}

initDio() {
  BaseOptions options = new BaseOptions(
    baseUrl: "https://api.themoviedb.org/3",
    connectTimeout: 50000,
    receiveTimeout: 30000,
  );
  Dio dio = new Dio(options);

  return dio;
}
