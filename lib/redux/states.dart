import '../data/HotMoviesData.dart';

class AppState {
  CityState _cityState;
  HotMoviesState _hotMoviesState;

  get cityState => _cityState;
  get hotMoviesState => _hotMoviesState;
  
  AppState(this._cityState, this._hotMoviesState);
}

class CityState {
  String _curCity;

  get curCity => _curCity;

  CityState(this._curCity);
}

class HotMoviesState {
  int _code;
  List<HotMoviesData> _hotMoviesList;

  get code => _code;
  get hotMoviesList => _hotMoviesList;

  HotMoviesState(this._code, this._hotMoviesList);
}