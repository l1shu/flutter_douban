import 'package:flutter/material.dart';

class CitysList extends StatefulWidget {
  final curCity;
  final hotCitys;

  CitysList(this.curCity, this.hotCitys);

  @override
  _CitysListState createState() => _CitysListState();
}

class _CitysListState extends State<CitysList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 50,
          child: TextField(
            cursorColor: Colors.green,
            decoration: InputDecoration(
              hintText: '输入城市名查询',
              hintStyle: TextStyle(fontSize: 14),
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: Colors.black38),
              filled: true,
              fillColor: Colors.white
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, left: 20),
          child: Text(
            'GPS定位城市',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5, left: 20),
          child: MaterialButton(
            child: Container(
              width: 50,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    size: 14,
                    color: Colors.green,
                  ),
                  Text(widget.curCity)
                ],
              ),
            ),
            color: Colors.white,
            elevation: 0,
            onPressed: () {},
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5, left: 20),
          child: Text(
            '热门城市',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.6,
                mainAxisSpacing: 20,
                crossAxisSpacing: 50
              ),
              itemCount: widget.hotCitys.length,
              itemBuilder: (BuildContext context, int index) {
                return MaterialButton(
                  child: Text(widget.hotCitys[index]),
                  color: Colors.white,
                  elevation: 0,
                  onPressed: () {
                    Navigator.pop(context, widget.hotCitys[index]);
                  },
                );
              },
            ),
          ),
        )
      ],
    );
  }
}