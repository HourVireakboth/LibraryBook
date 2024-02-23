import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:librarybook/data/response/status.dart';
import 'package:librarybook/provider/book.dart';
import 'package:librarybook/res/constants/app_color.dart';
import 'package:librarybook/viewmodels/book_viewmodel.dart';

import 'package:librarybook/views/pages/library/add_edit_book.dart';
import 'package:librarybook/views/pages/library/widgets/lirbray_book_card.dart';
import 'package:librarybook/views/pages/main_page.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

// import '../../../models/bookmodel.dart';

class LibraryScreen extends StatefulWidget {
  LibraryScreen({super.key, this.isUpdate});
  var isUpdate;

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final bookViewModel = BookViewModel();
  var scrollControll = ScrollController();
  var page = 1;
  bool refresh = false;
  // var data = [];
  // var dataset = [];
  var delete = true;
  bool? dataUpdate;

  bool isLoading = false;
  //var limit;
  //var maxpagesize = 0;

  @override
  void initState() {
    refresh = true;
    bookViewModel.getBookPage(1, 5);
    scrollControll.addListener(onScrollToTheMaxBottom);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.bgcolor,
      appBar: AppBar(
        leading: widget.isUpdate == true
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                      (route) => false);
                },
              )
            : null,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Appcolor.bgcolor,
        title: const Text('Library'),
        titleSpacing: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
            fontSize: 30, fontWeight: FontWeight.w700, color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 100, right: 20),
            child: CircleAvatar(
                backgroundColor: Appcolor.nbcolor,
                radius: 20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return AddandEditBook(
                            isUpdate: false,
                            isCreate: true,
                          );
                        }));
                      });
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )),
          )
        ],
      ),
      body: SizedBox(
        child: ChangeNotifierProvider.value(
          value: bookViewModel,
          child: Consumer2<BookViewModel, Book>(
            builder: (context, viewModel, booksdata, _) {
              // int? length = viewModel.apiResponse.data?.data?.length;
              // for (int index = 0; index < length!; index++) {
              //   var bookid = viewModel.apiResponse.data?.data?[index].id;
              //   LibraryScreen.listbook.add(bookid);
              // }
              // print('BookCout = ${LibraryScreen.listbook.length}');
              switch (viewModel.apiResponse.status) {
                case Status.LOADING:
                  return Center(
                    child: Lottie.network(
                      'https://assets4.lottiefiles.com/packages/lf20_hwm68tlm.json',
                      fit: BoxFit.cover,
                    ),
                  );
                case Status.COMPLETED:
                  if (delete == true) {
                    booksdata.addBook(
                        viewModel.apiResponse.data!.data!, refresh);
                    // data.addAll(viewModel.apiResponse.data!.data!);
                    //dataset = data.toSet().toList();
                  }
                  //var book = viewModel.apiResponse.data!;
                  //var length = data.length;
                  var length = booksdata.items.length;
                  return RefreshIndicator(
                    onRefresh: () async {
                      page = 1;
                      refresh = true;
                      print("List Book =${booksdata.items.length} ");
                      delete = true;
                      bookViewModel.getBookPage(page, 5);
                    },
                    child: ListView.builder(
                        controller: scrollControll,
                        itemCount: length, //isLoading ? length + 1 : length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          var bookid = booksdata.items[index].id;
                          var bookcard = booksdata.items[index].attributes;
                          var book = booksdata.items[index];

                          return Slidable(
                            key: UniqueKey(),
                            startActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                dismissible: DismissiblePane(onDismissed: () {
                                  setState(() {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: const Text(
                                                  'Are you sure to remove'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('NO')),
                                                TextButton(
                                                    onPressed: () {
                                                      bookViewModel
                                                          .deleteBook(bookid);
                                                      delete = false;
                                                      booksdata
                                                          .removeBook(index);
                                                      // data.removeAt(index);
                                                      // dataset.removeAt(index);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: viewModel.apiResponse
                                                                .status ==
                                                            Status.LOADING
                                                        ? const CircularProgressIndicator()
                                                        : const Text('Yes')),
                                                //   }),
                                                // )
                                              ],
                                            ));
                                  });
                                }),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: const Text(
                                                    'Are you sure to remove'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text('NO')),
                                                  TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          bookViewModel
                                                              .deleteBook(
                                                                  bookid);
                                                          delete = false;
                                                          booksdata.removeBook(
                                                              index);
                                                          // data.removeAt(index);
                                                          // dataset
                                                          //     .removeAt(index);
                                                          Navigator.of(context)
                                                              .pop();
                                                        });
                                                      },
                                                      child: viewModel
                                                                  .apiResponse
                                                                  .status ==
                                                              Status.LOADING
                                                          ? const CircularProgressIndicator()
                                                          : const Text('Yes')),
                                                  //   }),
                                                  // )
                                                ],
                                              ));
                                    },
                                    label: 'Delete',
                                    backgroundColor: Colors.red,
                                    icon: Icons.delete,
                                  ),
                                  SlidableAction(
                                    onPressed: (context) async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddandEditBook(
                                                    isUpdate: true,
                                                    isCreate: true,
                                                    index: index,
                                                    book: book,
                                                    bookid: bookid,
                                                  )));
                                      // if (result == true) {
                                      //   setState(() {
                                      //     dataset.
                                      //     print('result = $result');
                                      //   });
                                      //   print('data = $dataUpdate');
                                      // }
                                    },
                                    label: 'Edit',
                                    backgroundColor: Colors.amber,
                                    icon: Icons.edit,
                                  ),
                                ]),
                            child: index == length
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : LibraryBookCard(
                                    book: bookcard,
                                    
                                  ),
                          );

                          //final urlBook = urlBooks[index];
                        }),
                  );
                case Status.ERROR:
                  return Center(
                      child: Text(viewModel.apiResponse.message.toString()));
                default:
                  return Center(
                    child: Lottie.network(
                      'https://assets4.lottiefiles.com/packages/lf20_hwm68tlm.json',
                      fit: BoxFit.cover,
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  void onScrollToTheMaxBottom() async {
    if (scrollControll.position.pixels ==
        scrollControll.position.maxScrollExtent) {
      if (page != 4) {
        setState(() {
          isLoading = true;
        });
        //data.clear();
        page += 1;
        print('Loading Next Page');
        refresh = false;
        await bookViewModel.getBookPage(page, 5);

        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
