import 'package:flutter/material.dart';

import '../../../../res/constants/app_color.dart';

class CardSlider extends StatelessWidget {
  const CardSlider({
    super.key,
    required this.urlImage,
  });

  final String urlImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:BoxDecoration(
        
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
        image: DecorationImage(
          image: AssetImage(urlImage),
          fit: BoxFit.cover
          ),
        boxShadow: [
        BoxShadow(
            color: Appcolor.fixcolor.withOpacity(0.8),
            offset: const Offset(1,1),
            blurRadius: 10,
            spreadRadius: 5)
      ]
      ) ,
    );
  }
}