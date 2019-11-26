import 'package:flutter/material.dart';
import 'package:flutter_douban/routes/Hot.dart';
import 'package:flutter_douban/routes/Movies.dart';
import 'package:flutter_douban/routes/Mine.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '豆瓣电影'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final _widgetItems = [HotRoute(), MoviesRoute(), MineRoute()];
  
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
      body: _widgetItems[_selectedIndex]
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;//刷新界面
    });
  }
}
