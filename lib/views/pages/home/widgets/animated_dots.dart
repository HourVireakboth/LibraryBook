// ignore: file_names
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class AnimatedSmoothDots extends StatelessWidget {
  AnimatedSmoothDots({
    this.activeIndex,
    this.urlImages,
    super.key,
  });
  int? activeIndex;
  List<String>? urlImages;
  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex!,
      count: urlImages!.length,
      effect: const ExpandingDotsEffect(
        dotHeight: 8,
        dotWidth: 8,
      ),
    );
  }
}
