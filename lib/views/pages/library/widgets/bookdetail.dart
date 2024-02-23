import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:librarybook/models/bookmodel.dart';
import 'package:librarybook/models/serachmodel.dart';
import 'package:librarybook/res/constants/app_color.dart';

class BookDetail extends StatefulWidget {
  BookDetail(
      {super.key, this.book, this.books, this.isSearching, this.bookData ,this.isHomeCardClick});
  Attributes? book;
  BookData? bookData;
  BookDataSearch? books;

  var isSearching;
  var isHomeCardClick;
  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> with TickerProviderStateMixin {
  var _tabcontroller;
  @override
  void initState() {
    _tabcontroller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.bgcolor,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          'Read Book',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [],
        backgroundColor: Appcolor.nbcolor.withOpacity(0.5),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 15, left: 50, right: 50, bottom: 20),
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                color: Appcolor.nbcolor.withOpacity(0.5),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const  [
                            BoxShadow(
                                color:  Appcolor.transparentcolor,
                                offset:  Offset(2, 2),
                                blurRadius: 3,
                                spreadRadius: 2)
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: widget.isSearching == true
                            ? widget.books!.attributes?.thumbnail?.data
                                        ?.attributes?.url ==
                                    null
                                ? Image.network(
                                    'https://cms.istad.co/uploads/thumbnail_Nullimage_11064259fd.PNG',
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 220,
                                  )
                                : Image.network(
                                    'https://cms.istad.co${widget.books!.attributes?.thumbnail?.data?.attributes?.url}',
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 220,
                                  )
                            : widget.isHomeCardClick == true ?  
                                widget.bookData?.attributes?.thumbnail?.data?.attributes?.url ==
                                    null
                                ? Image.network(
                                    'https://cms.istad.co/uploads/thumbnail_Nullimage_11064259fd.PNG',
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 220,
                                  )
                                : Image.network(
                                    'https://cms.istad.co${widget.bookData?.attributes?.thumbnail?.data?.attributes?.url}',
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 220,
                                  ):
                                  widget.book?.thumbnail?.data?.attributes!.url ==
                                    null
                                ? Image.network(
                                    'https://cms.istad.co/uploads/thumbnail_Nullimage_11064259fd.PNG',
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 220,
                                  )
                                : Image.network(
                                    'https://cms.istad.co${widget.book?.thumbnail?.data?.attributes?.url}',
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 220,
                                  ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: widget.isSearching == true
                          ? Text(
                              '${widget.books!.attributes!.title}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            )
                          : widget.isHomeCardClick == true ? Text(
                              '${widget.bookData?.attributes?.title}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            )  : Text(
                              '${widget.book?.title}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    widget.isSearching == true
                        ? Text(
                            '${widget.books!.attributes!.ibAuthor!.data!.attributes!.name}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          )
                        : widget.isHomeCardClick == true ? 
                        Text(
                            '${widget.bookData?.attributes?.ibAuthor?.data?.attributes?.name}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ) : Text(
                            '${widget.book?.ibAuthor!.data!.attributes!.name}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          )
                  ],
                ),
              ),
            ),
            CustomScrollView(
              anchor: 0.4,
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Appcolor.bgcolor,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(0),
                            child: TabBar(
                              controller: _tabcontroller,
                              labelColor: Colors.black,
                              indicatorColor: Colors.black,
                              labelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                              indicatorSize: TabBarIndicatorSize.label,
                              tabs: const [
                                Tab(
                                  text: "Description",
                                ),
                                Tab(
                                  text: "About",
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(0),
                              child: TabBarView(
                                controller: _tabcontroller,
                                children: [
                                  // Tab Description
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: widget.isSearching == true
                                        ? Text(
                                            '${widget.books?.attributes!.description}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              wordSpacing: 5,
                                              height: 3,
                                            ),
                                            textAlign: TextAlign.justify,
                                          )
                                        : widget.isHomeCardClick == true ? 
                                        Text(
                                            '${widget.bookData?.attributes?.description}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              wordSpacing: 5,
                                              height: 3,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ) : Text(
                                            '${widget.book?.description}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              wordSpacing: 5,
                                              height: 3,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                  ),

                                  // Tab Author
                                  Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 65),
                                      child: Column(
                                        children: [
                                          Column(
                                            children: [
                                              widget.isSearching == true
                                                  ? Text(
                                                      '${widget.books?.attributes!.ibAuthor!.data!.attributes!.name}',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 24,
                                                      ),
                                                    )
                                                  : widget.isHomeCardClick == true ? Text (
                                                      '${widget.bookData?.attributes?.ibAuthor?.data?.attributes?.name}',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 24,
                                                      ),
                                                    ) : Text (
                                                      '${widget.book?.ibAuthor!.data!.attributes!.name}',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 24,
                                                      ),
                                                    ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Text(
                                                'Author',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 24,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(
                                            height: 30,
                                          ),
                                          // Author Status

                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(50.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  //todo author information here
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      widget.isSearching == true
                                                          ? Text(
                                                              '\$${widget.books?.attributes!.price}',
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            )
                                                          : widget.isHomeCardClick == true ? 
                                                          Text(
                                                              '\$${widget.bookData?.attributes?.price}',
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ): Text(
                                                              '\$${widget.book?.price}',
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      const Text(
                                                        'Price',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      widget.isSearching == true
                                                          ? Text(
                                                              '${widget.books?.attributes!.starReview}',
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            )
                                                          : widget.isHomeCardClick == true ? 
                                                          Text(
                                                              '${widget.bookData?.attributes?.starReview}',
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ): 
                                                            Text(
                                                              '${widget.book?.starReview}',
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      const Text(
                                                        'Review',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      widget.isSearching == true
                                                          ? Text(
                                                              '${DateFormat.yMEd().format(DateTime.parse('${widget.books!.attributes!.createdAt}'))}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade800,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            )
                                                          : widget.isHomeCardClick == true ? 
                                                          Text(
                                                              '${DateFormat.yMEd().format(DateTime.parse('${widget.bookData?.attributes?.createdAt}'))}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade800,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ): 
                                                            Text(
                                                              '${DateFormat.yMEd().format(DateTime.parse('${widget.book!.createdAt}'))}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade800,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      const Text(
                                                        'Release Date',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),

                                          const SizedBox(
                                            height: 25,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Book Code',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 24,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              widget.isSearching == true
                                                  ? Text(
                                                      '${widget.books?.attributes!.code}',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 24,
                                                        color: Colors.black,
                                                      ),
                                                    )
                                                  : widget.isHomeCardClick == true ? 
                                                  Text(
                                                      '${widget.bookData?.attributes?.code}',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 24,
                                                        color: Colors.black,
                                                      ),
                                                    ) :  
                                                    Text(
                                                      '${widget.book?.code}',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 24,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
