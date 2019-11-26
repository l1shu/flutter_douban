import 'package:flutter/material.dart';

// 评分数值变化回调 typedef RatingChangeCallback = void Function(double rating);
typedef void RatingChangeCallback(double rating);

class StarRatingBar extends StatefulWidget {
  final double rating;
  final double totalRating;
  final int starCount;
  final double starSize;
  final Color color;
  final RatingChangeCallback onRatingCallback;

  StarRatingBar({
    Key key,
    @required this.rating,
    @required this.totalRating,
    @required this.starCount,
    @required this.starSize,
    this.color,
    this.onRatingCallback,
  });

  @override
  _StarRatingBarState createState() => _StarRatingBarState(
    rating: this.rating,
    totalRating: this.totalRating,
    starCount: this.starCount,
    starSize: this.starSize,
    color: this.color,
    onRatingCallback: this.onRatingCallback,
  );
}

class _StarRatingBarState extends State<StarRatingBar> {
  double rating; // 不能置为final，因为rating可能从内部改变
  final double totalRating;
  final int starCount;
  final double starSize;
  final Color color;
  final RatingChangeCallback onRatingCallback;

  // 每个星星的权重，比如总分10分，有5个星星，那么每个星星的权重是2分
  double weight;

  _StarRatingBarState({
    this.rating,
    this.totalRating,
    this.starCount,
    this.starSize,
    this.color,
    this.onRatingCallback,
  }) {
    weight = totalRating / starCount;
  }

  // 通过滑动的距离来计算出当前评分数值
  double getRatingByDx(double dragDx) {
    if (dragDx <= 0) return 0.0;

    for (int i = 1; i <= starCount; i++) {
      if (dragDx < starSize * i) {
        if (dragDx < starSize * i - starSize / 2) {
          return i * weight - weight / 2;
        }
        return i * weight;
      }
    }
    return starCount * weight;
  }
  
  @override
  Widget build(BuildContext context) {
    void onRatingUpdate(double rating) {
      onRatingCallback(rating);
      setState(() {
        this.rating = rating;
      });
    }

    return GestureDetector(
      onHorizontalDragUpdate: onRatingCallback == null ? null : (DragUpdateDetails details) {
        RenderBox getBox = context.findRenderObject();
        // 将全局坐标转换为当前盒子内部的坐标
        double dragDx = getBox.globalToLocal(details.globalPosition).dx;
        onRatingUpdate(getRatingByDx(dragDx));
      },
      child: StarRating(
        rating: rating,
        totalRating: totalRating,
        starCount: starCount,
        starSize: starSize,
        color: color,
        weight: weight,
        onRatingChanged: onRatingCallback == null ? null : (rating) => onRatingUpdate(rating)
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  final double totalRating;
  final int starCount;
  final double starSize;
  final Color color;
  final RatingChangeCallback onRatingChanged;
  final double weight;

  StarRating({
    @required this.starCount,
    @required this.starSize,
    this.rating = 0.0,
    this.totalRating = 10.0,
    this.onRatingChanged,
    this.color,
    this.weight
  });

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    // 每个星星的取值范围，比如totalRating=10，starCount=5，那么第一个星星的取值范围是 0-2
    double rangeLeft = index * weight;
    double rangeRight = rangeLeft + weight;

    if (rating <= rangeLeft) {
      icon = Icon(
        Icons.star_border,
        color: Theme.of(context).buttonColor,
        size: starSize,
      );
    } else if (rating > rangeLeft && rating < rangeRight) {
      icon = new Icon(
        Icons.star_half,
        color: color ?? Theme.of(context).primaryColor,
        size: starSize,
      );
    } else {
      icon = new Icon(
        Icons.star,
        color: color ?? Theme.of(context).primaryColor,
        size: starSize,
      );
    }
    return GestureDetector(
      onTap: onRatingChanged == null ? null : () => onRatingChanged(rangeRight),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) => buildStar(context, index)),
    );
  }
}
