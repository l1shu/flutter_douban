import 'package:flutter/material.dart';
import 'package:flutter_douban/widgets/HotMoviesList.dart';
import 'package:flutter_douban/common/StarRatingBar.dart';

class HotRoute extends StatefulWidget {
  @override
  _HotRouteState createState() => _HotRouteState();
}

class _HotRouteState extends State<HotRoute> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 80.0,
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: <Widget>[
              Text('深圳', style: TextStyle(fontSize: 16)),
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
                      HotMoviesList(),
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
  }
}