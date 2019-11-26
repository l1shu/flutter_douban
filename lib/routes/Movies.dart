import 'package:flutter/material.dart';

class MoviesRoute extends StatefulWidget {
  @override
  _MoviesRouteState createState() => _MoviesRouteState();
}

class _MoviesRouteState extends State<MoviesRoute> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 80.0,
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.only(left: 20, right: 20),
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
                      Tab(text: '电影',),
                      Tab(text: '电视',)
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      Center(
                        child: Text('电影'),
                      ),
                      Center(
                        child: Text('电视'),
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