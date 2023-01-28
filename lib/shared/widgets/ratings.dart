import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingsWidget extends StatefulWidget {
  const RatingsWidget({
    Key? key,
    required this.ratings,
    this.size,
    this.isActive = false,
  }) : super(key: key);
  final int ratings;
  final double? size;
  final bool? isActive;

  @override
  State<RatingsWidget> createState() => _RatingsWidgetState();
}

class _RatingsWidgetState extends State<RatingsWidget> {
  int rating = 0;
  @override
  void initState() {
    super.initState();
    rating = widget.ratings;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RatedStar(
            size: widget.size,
            isRated: rating > 0,
            onTap: () {
              if (widget.isActive!) {
                if (rating == 1) {
                  rating = 0;
                } else {
                  rating = 1;
                }
                setState(() {});
              }
            }),
        RatedStar(
            size: widget.size,
            isRated: rating > 1,
            onTap: () {
              if (widget.isActive!) {
                if (rating == 2) {
                  rating = 1;
                } else {
                  rating = 2;
                }
                setState(() {});
              }
            }),
        RatedStar(
            size: widget.size,
            isRated: rating > 2,
            onTap: () {
              if (widget.isActive!) {
                if (rating == 3) {
                  rating = 2;
                } else {
                  rating = 3;
                }
                setState(() {});
              }
            }),
        RatedStar(
            size: widget.size,
            isRated: rating > 3,
            onTap: () {
              if (widget.isActive!) {
                if (rating == 4) {
                  rating = 3;
                } else {
                  rating = 4;
                }
                setState(() {});
              }
            }),
        RatedStar(
            size: widget.size,
            isRated: rating > 4,
            onTap: () {
              if (widget.isActive!) {
                if (rating == 5) {
                  rating = 4;
                } else {
                  rating = 5;
                }
                setState(() {});
              }
            }),
      ],
    );
  }
}

class RatedStar extends StatelessWidget {
  const RatedStar({
    Key? key,
    this.size,
    required this.isRated,
    this.onTap,
  }) : super(key: key);
  final double? size;
  final bool isRated;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        isRated ? Icons.star : Icons.star_border,
        color: Colors.amber,
        size: size ?? 11
          ..h,
      ),
    );
  }
}
