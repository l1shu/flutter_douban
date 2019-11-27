import 'package:flutter/material.dart';
import '../widgets/Citys/CitysList.dart';

class Citys extends StatefulWidget {
  @override
  _CitysState createState() => _CitysState();
}

class _CitysState extends State<Citys> {
  String curCity;
  List<String> hotCitys = [
      '北京',
      '上海',
      '广州',
      '深圳',
      '成都',
      '武汉',
      '杭州',
      '重庆',
      '郑州',
      '南京',
      '西安',
      '苏州',
      '长沙',
      '天津',
      '福州'
    ];

  @override
  Widget build(BuildContext context) {
    curCity = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Color(0xE3FFFFFF),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green),
        title: Text('选择城市',style: TextStyle(color: Colors.black,fontSize: 16),),
        backgroundColor: Colors.white,
        elevation: 1, // 控制下方阴影面积
        centerTitle: false,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(height: 50),
              color: Colors.white,
                child: TabBar(
                unselectedLabelColor: Colors.black12,
                labelColor: Colors.black87,
                indicatorColor: Colors.green,
                tabs: <Widget>[Tab(text: '国内'), Tab(text: '国外')],
              ),
            ),
            Expanded(
              flex: 1,
              child: TabBarView(
                physics: ClampingScrollPhysics(), // 这是啥？
                children: <Widget>[
                  CitysList(curCity, hotCitys),
                  Center(
                    child: Text('国外'),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}