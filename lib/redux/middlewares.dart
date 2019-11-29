import './actions.dart';
import './states.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux/redux.dart';
import '../data/HotMoviesData.dart';
import 'package:flutter_douban/http.dart';

void appMiddlewares(Store<AppState> store, Object action,  NextDispatcher next) async {
  print('middleware: $action');
  if (action is InitCityAction) {
    initCity(store);
  }
  if (action is ChangeCityAction) {
    // 先清空
    store.dispatch(FetchHotMoviesListErrorAction(200));
    getHotMovies(store, action.city);
  }
  next(action);
}

void initCity(Store<AppState> store) async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); //获取 prefs
  String city = prefs.getString('curCity'); // 获取 key 为 curCity 的值

  print('本地存储city：$city');
  if (city == null || city.isEmpty) {
    //如果 city 为空，则使用默认值
    city = '深圳';
  }
  
  store.dispatch(ChangeCityAction(city));
}

void getHotMovies(Store<AppState> store, String curCity) async {
  List<HotMoviesData> serverDataList = new List();
  var res = await dio.get('https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&city=${Uri.encodeComponent(curCity)}&start=0&count=10&client=&udid=');
  print('请求码: ${res.statusCode}');
  if (res.statusCode == 200) {
    var data = res.data;
    for (var item in data['subjects']) {
      HotMoviesData hotMoviesData = HotMoviesData.fromJson(item);
      serverDataList.add(hotMoviesData);
    }
    
    store.dispatch(FetchHotMoviesListSuccessAction(200, serverDataList));
  } else {
    store.dispatch(FetchHotMoviesListErrorAction(res.statusCode));
  }
}
