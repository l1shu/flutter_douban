import 'package:flutter/material.dart';
import 'package:flutter_douban/data/HotMoviesData.dart';
import 'package:flutter_douban/common/StarRatingBar.dart';

class HotMoviesItem extends StatefulWidget {
  final HotMoviesData hotMoviesData;

  HotMoviesItem(this.hotMoviesData);

  @override
  _HotMoviesItemState createState() => _HotMoviesItemState();
}

class _HotMoviesItemState extends State<HotMoviesItem> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      padding: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Image.network(
            widget.hotMoviesData.images.small,
            width: 80,
            height: 120,
            fit: BoxFit.cover,
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.hotMoviesData.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)
                  ),
                  Row(
                    children: <Widget>[
                      StarRatingBar(
                        totalRating: 10,
                        rating: widget.hotMoviesData.rating.average,
                        starCount: 5,
                        starSize: 15,
                        color: Colors.orange,
                      ),
                      Text(
                        widget.hotMoviesData.rating.average.toString(),
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Text(
                    '导演：${widget.hotMoviesData.getDirectors()}',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  Text(
                    '主演：${widget.hotMoviesData.getCasts()}',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ),
          Container(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${widget.hotMoviesData.collectCount.toString()}人看过',
                  style: TextStyle(color: Colors.red,fontSize: 14),
                ),
                OutlineButton(
                  child: Text('购票', style: TextStyle(fontSize: 16),),
                  textColor: Colors.red,
                  highlightedBorderColor: Colors.red,
                  borderSide: BorderSide(color: Colors.red),
                  onPressed: () {
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}