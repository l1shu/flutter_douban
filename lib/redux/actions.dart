import '../data/HotMoviesData.dart';

class InitCityAction {
  InitCityAction();
}

class ChangeCityAction {
  String _city;

  get city => _city;

  ChangeCityAction(this._city);
}

class FetchHotMoviesListSuccessAction {
  int _code;
  List<HotMoviesData> _hotMoviesList;

  get code => _code;
  get hotMoviesList => _hotMoviesList;

  FetchHotMoviesListSuccessAction(this._code, this._hotMoviesList);
}

class FetchHotMoviesListErrorAction {
  int _code;
  
  get code => _code;

  FetchHotMoviesListErrorAction(this._code);
}