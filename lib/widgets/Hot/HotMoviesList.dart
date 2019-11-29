import 'package:flutter/material.dart';
import 'package:flutter_douban/data/HotMoviesData.dart';
import './HotMoviesItem.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_douban/redux/states.dart';

class HotMoviesList extends StatefulWidget {
  final String curCity;

  HotMoviesList(this.curCity);

  @override
  _HotMoviesListState createState() => _HotMoviesListState();
}

class _HotMoviesListState extends State<HotMoviesList> with AutomaticKeepAliveClientMixin {
  // 切换 Widget 的时候，为了节约内存不会保存widget的状态, initState又会被调用一次。
  // 为了让tab一直保存在内存中，不被销毁
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector(
      converter: (Store<AppState> store) {
        List<HotMoviesData> hotMoviesList = store.state.hotMoviesState.hotMoviesList;
        return hotMoviesList;
      },
      builder: (BuildContext context, List<HotMoviesData>hotMoviesList) {
        if (hotMoviesList == null || hotMoviesList.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // 当 ListView 没有和 AppBar 一起使用的时候，头部就会有一个 padding
          return MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView.separated(
              itemCount: hotMoviesList.length,
              itemBuilder: (context, index) {
                return HotMoviesItem(hotMoviesList[index]);
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
      },
    );
  }
}