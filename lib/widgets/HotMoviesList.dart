import 'package:flutter/material.dart';
import 'package:flutter_douban/data/HotMoviesData.dart';
import 'package:flutter_douban/widgets/HotMoviesItem.dart';
import 'package:flutter_douban/http.dart';

class HotMoviesList extends StatefulWidget {
  @override
  _HotMoviesListState createState() => _HotMoviesListState();
}

class _HotMoviesListState extends State<HotMoviesList> with AutomaticKeepAliveClientMixin {
  List<HotMoviesData> hotMovies = List<HotMoviesData>();

  @override
  void initState() {
    super.initState();
    _getHotMovies();
  }

  void _getHotMovies() async {
    List<HotMoviesData> serverDataList = new List();
    var res = await dio.get('https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E6%B7%B1%E5%9C%B3&start=0&count=10&client=&udid=');
    if (res.statusCode == 200) {
      var data = res.data;
      for (var item in data['subjects']) {
        HotMoviesData hotMoviesData = HotMoviesData.fromJson(item);
        serverDataList.add(hotMoviesData);
      }
      setState(() {
        hotMovies = serverDataList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (hotMovies == null || hotMovies.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      // 当 ListView 没有和 AppBar 一起使用的时候，头部就会有一个 padding
      return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView.separated(
          itemCount: hotMovies.length,
          itemBuilder: (context, index) {
            return HotMoviesItem(hotMovies[index]);
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 1,
              color: Colors.black26,
            );
          },
        )
      );
    }
  }

  // 切换 Widget 的时候，为了节约内存不会保存widget的状态, initState又会被调用一次。
  // 为了让tab一直保存在内存中，不被销毁
  @override
  bool get wantKeepAlive => true;
}