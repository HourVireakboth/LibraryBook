import 'package:flutter/material.dart';
import 'package:librarybook/models/authormodel.dart';
import '../../../../res/constants/app_color.dart';

class AuthorCard extends StatefulWidget {
  AuthorCard({super.key, this.author});
  AuthorsData? author;
  @override
  State<AuthorCard> createState() => _AuthorCardState();
}

class _AuthorCardState extends State<AuthorCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(0),
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Appcolor.fixcolor,
                boxShadow: [
                  BoxShadow(
                      color: Appcolor.fixcolor.withOpacity(0.5),
                      offset: const Offset(1, 1),
                      blurRadius: 3,
                      spreadRadius: 2)
                ]),
            child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    'https://cms.istad.co${widget.author?.attributes?.photo?.data?.attributes?.url}')),
          ),
          const SizedBox(
            height: 10,
          ),
           Text('${widget.author?.attributes?.name}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
