import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:librarybook/viewmodels/book_viewmodel.dart';
import 'package:librarybook/views/pages/library/widgets/bookdetail.dart';
import '../../../../models/bookmodel.dart';
import '../../../../res/constants/app_color.dart';

class LibraryBookCard extends StatefulWidget {
  LibraryBookCard({super.key, this.book});
  Attributes? book;
  //BookData? books;
  //var bookid;
  //var index;
  @override
  State<LibraryBookCard> createState() => _LibraryBookCardState();
}

class _LibraryBookCardState extends State<LibraryBookCard> {
  var bookViewModel = BookViewModel();
  double rating = 0;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookDetail(
                      book: widget.book!,
                      isSearching: false,
                    )));
      },
      child: Card(
        color: Appcolor.bgcolor,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Appcolor.fixcolor,
                      image: DecorationImage(
                          image: widget
                                      .book?.thumbnail!.data?.attributes!.url ==
                                  null
                              ? const NetworkImage(
                                  'https://cms.istad.co/uploads/thumbnail_Nullimage_11064259fd.PNG',
                                )
                              : NetworkImage(
                                  'https://cms.istad.co${widget.book?.thumbnail?.data?.attributes?.url}'),
                          fit: BoxFit.cover),
                      boxShadow: [
                        BoxShadow(
                            color: Appcolor.fixcolor.withOpacity(0.5),
                            offset: const Offset(2, 2),
                            blurRadius: 3,
                            spreadRadius: 2)
                      ]),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                  flex: 14,
                  child: Container(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Title : ${widget.book?.title}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Author : ${widget.book?.ibAuthor?.data?.attributes?.name}',
                          style: TextStyle(color: Colors.grey.shade800),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Release : ${DateFormat.yMEd().format(DateTime.parse('${widget.book?.createdAt}'))}',
                          style: TextStyle(color: Colors.grey.shade800),
                        ),
                        RatingBar.builder(
                            itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                            updateOnDrag: true,
                            initialRating: double.parse('${widget.book?.starReview!}'),
                            itemSize: 30,
                            minRating: 1,
                            maxRating: 5,
                            onRatingUpdate: (rating) {
                              setState(() {
                                this.rating = rating;
                              });
                            }),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
