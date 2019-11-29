import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './HotMoviesList.dart';
import 'package:flutter_douban/common/StarRatingBar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_douban/redux/states.dart';
import 'package:flutter_douban/redux/actions.dart';

class HotRoute extends StatefulWidget {
  @override
  _HotRouteState createState() => _HotRouteState();
}

class _HotRouteState extends State<HotRoute> {

  void _jumpToCitys(Store<AppState> store, String curCity) async {
    var selectCity = await Navigator.pushNamed(context, '/Citys', arguments: curCity);
    if (selectCity != null) {

      SharedPreferences prefs = await SharedPreferences.getInstance(); 
      prefs.setString('curCity', selectCity); //存取数据

      store.dispatch(ChangeCityAction(selectCity));
      print('select $selectCity');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: (Store<AppState> store) {
        String curCity = store.state.cityState.curCity;
        if (curCity == null) {
          store.dispatch(InitCityAction());
        }
        return store;
      },
      builder: (BuildContext context, Store<AppState> store) {
        String curCity = store.state.cityState.curCity;
        if (curCity != null && curCity.isNotEmpty) {  
          return Column(
            children: <Widget>[
              Container(
                height: 80.0,
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      child: Text(curCity, style: TextStyle(fontSize: 16)),
                      onTap: () {
                        _jumpToCitys(store, curCity);
                      },
                    ),
                    Icon(Icons.arrow_drop_down),
                    Expanded(
                      flex: 1,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 40),
                        child: TextField(
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            hintText: '电影 / 电视剧 / 影人',
                            prefixIcon: Icon(Icons.search, color: Colors.black26,),
                            hintStyle: TextStyle(fontFamily: 'MaterialIcons', fontSize: 16),
                            contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 0), // 如果加入prefixIcon，就会出现一个最小的高度，这个就失效了，解决办法是在外层包一个ConstrainedBox
                            filled: true,
                            fillColor: Colors.black12,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(5))
                            )
                          ),
                        ),
                      )
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: DefaultTabController(
                  length: 2,
                  initialIndex: 0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints.expand(height: 50),
                        child: TabBar(
                          unselectedLabelColor: Colors.black12,
                          labelColor: Colors.black87,
                          indicatorColor: Colors.black87,
                          tabs: <Widget>[
                            Tab(text: '正在热映',),
                            Tab(text: '即将上映',)
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: <Widget>[
                            HotMoviesList(curCity),
                            Center(
                              child: StarRatingBar(
                                rating: 5,
                                totalRating: 20,
                                starCount: 5,
                                starSize: 20,
                                color: Colors.red,
                                onRatingCallback: (double rating) {
                                  print(rating);
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}