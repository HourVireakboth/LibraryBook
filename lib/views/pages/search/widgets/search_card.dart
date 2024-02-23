import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:librarybook/models/serachmodel.dart';
import 'package:librarybook/viewmodels/book_viewmodel.dart';
import 'package:librarybook/views/pages/library/add_edit_book.dart';
import 'package:provider/provider.dart';
import '../../../../data/response/status.dart';
import '../../../../res/constants/app_color.dart';
import '../../library/widgets/bookdetail.dart';

class SearchBookCard extends StatefulWidget {
  SearchBookCard({super.key, this.book});
  BookDataSearch? book;
  //var index;
  @override
  State<SearchBookCard> createState() => _SearchBookCardState();
}

class _SearchBookCardState extends State<SearchBookCard> {
  var bookViewModel = BookViewModel();
  @override
  Widget build(BuildContext context) {
    return Container(
        
      child: InkWell(
          onTap: () {
             Navigator.push(context,
                MaterialPageRoute(builder: (context) => BookDetail(books: widget.book, isSearching: true,)));
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
                              image: widget.book!.attributes?.thumbnail?.data
                                          ?.attributes?.url ==
                                      null
                                  ? const NetworkImage(
                                      'https://cms.istad.co/uploads/thumbnail_Nullimage_11064259fd.PNG',
                                    )
                                  : NetworkImage(
                                      'https://cms.istad.co${widget.book!.attributes?.thumbnail?.data?.attributes?.url}'),
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
                              'Title : ${widget.book!.attributes?.title}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Author : ${widget.book!.attributes?.ibAuthor?.data?.attributes?.name}',
                              style: TextStyle(color: Colors.grey.shade800),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Release : ${DateFormat.yMEd().format(DateTime.parse('${widget.book!.attributes!.createdAt}'))}',
                              style: TextStyle(color: Colors.grey.shade800),
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
