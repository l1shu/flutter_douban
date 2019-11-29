import 'package:flutter/material.dart';
import '../widgets/Hot/Hot.dart';
import '../widgets/Movies/Movies.dart';
import '../widgets/Mine/Mine.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../redux/states.dart';
import '../redux/reducers.dart';
import '../redux/middlewares.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final _widgetItems = [HotRoute(), MoviesRoute(), MineRoute()];
  final _appStore = Store<AppState>(
    appReducer,
    initialState: AppState(CityState(null), HotMoviesState(null, null)),
    middleware: [appMiddlewares],
  );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('热映')),
          BottomNavigationBarItem(icon: Icon(Icons.panorama_fish_eye), title: Text('找片')),
          BottomNavigationBarItem(icon: Icon(Icons.people), title: Text('我的')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.black, //选中时颜色变为黑色
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
      body: StoreProvider<AppState>(
        store: _appStore,
        child: _widgetItems[_selectedIndex],
      )
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;//刷新界面
    });
  }
}
