import './actions.dart';
import './states.dart';

AppState appReducer(AppState state, Object action) {
  print('reducer: $action');
  return AppState(
    cityReducer(state, action),
    hotMoviesReducer(state, action)
  );
}

CityState cityReducer(AppState state, Object action) {
  if (action is ChangeCityAction) {
    return CityState(action.city);
  }
  return state.cityState;
}

HotMoviesState hotMoviesReducer(AppState state, Object action) {
  if (action is FetchHotMoviesListSuccessAction) {
    return HotMoviesState(action.code, action.hotMoviesList);
  }
  if (action is FetchHotMoviesListErrorAction) {
    return HotMoviesState(action.code, null);
  }

  return state.hotMoviesState;
}