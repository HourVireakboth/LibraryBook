import 'package:flutter/material.dart';
import 'package:librarybook/models/bookmodel.dart';
import 'package:librarybook/res/constants/app_color.dart';
import 'package:librarybook/viewmodels/book_viewmodel.dart';

import '../../library/widgets/bookdetail.dart';

class BookCard extends StatelessWidget {
  BookCard({super.key, required this.book,});
  //final String? urlBook;
  BookData book;
  var bookViewModel = BookViewModel();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 10 ,right: 10 ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookDetail(
                            isSearching: false, bookData: book, isHomeCardClick: true,
                          )));
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Appcolor.fixcolor,
                  image: DecorationImage(
                      image: book.attributes?.thumbnail?.data?.attributes
                                  ?.url ==
                              null
                          ? const NetworkImage(
                              'https://cms.istad.co/uploads/thumbnail_Nullimage_11064259fd.PNG',
                            )
                          : NetworkImage(
                              'https://cms.istad.co${book.attributes!.thumbnail!.data?.attributes!.url!}'),
                      fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                        color: Appcolor.fixcolor.withOpacity(0.5),
                        offset: const Offset(1, 1),
                        blurRadius: 3,
                        spreadRadius: 2)
                  ]),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Text('${book.attributes?.title}',
                maxLines: 2,
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Text(
              '${book.attributes?.ibAuthor?.data?.attributes?.name}',
            ),
          )
        ],
      ),
    );
  }
}
