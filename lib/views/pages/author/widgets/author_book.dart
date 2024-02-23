import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:librarybook/data/response/status.dart';
import 'package:librarybook/res/constants/app_color.dart';
import 'package:librarybook/viewmodels/book_viewmodel.dart';

import 'package:librarybook/views/pages/library/add_edit_book.dart';
import 'package:librarybook/views/pages/library/widgets/lirbray_book_card.dart';
import 'package:librarybook/views/pages/main_page.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

// import '../../../models/bookmodel.dart';

class ListAuthorBookScreen extends StatefulWidget {
  ListAuthorBookScreen({super.key, this.isUpdate, this.authorid});
  var isUpdate;
  var authorid;
  @override
  State<ListAuthorBookScreen> createState() => _ListAuthorBookScreenState();
}

class _ListAuthorBookScreenState extends State<ListAuthorBookScreen> {
  final bookViewModel = BookViewModel();
  var page = 1;
  var data = [];
  var data2 = [];
  var dataset = [];
  var delete = true;
  bool? dataUpdate;

  bool isLoading = false;
  //var limit;
  //var maxpagesize = 0;

  @override
  void initState() {
    bookViewModel.getAllBooks();
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
        title: const Text('Authors Book'),
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
          child: Consumer<BookViewModel>(
            builder: (context, viewModel, _) {
              //data.addAll(viewModel.apiResponse.data!.data!);
              //final length = viewModel.apiResponse.data?.data?.length;
              // for (int index = 0; index < data.length; index++) {
              //   var idauthor = viewModel.apiResponse.data?.data?[index]
              //       .attributes!.ibAuthor!.data!.id;
              //   if (idauthor == widget.authorid) {
              //     data2.add(viewModel.apiResponse.data!.data![index]);
              //   }
              // }
              viewModel.apiResponse.data?.data?.forEach((element) {
                if (element.attributes?.ibAuthor?.data?.id == widget.authorid) {
                  data2.add(element);
                }
              });
              print('BookCout =}');
              switch (viewModel.apiResponse.status) {
                case Status.LOADING:
                  return Center(
                    child: Lottie.network(
                      'https://assets4.lottiefiles.com/packages/lf20_hwm68tlm.json',
                      fit: BoxFit.cover,
                    ),
                  );
                case Status.COMPLETED:
                  dataset = data2.toSet().toList();
                  if (dataset.length > 0) {
                    //var book = viewModel.apiResponse.data!;
                    //var length = data.length;
                    var length = dataset.length;
                    return ListView.builder(
                        itemCount: length, //isLoading ? length + 1 : length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          var bookid = dataset[index].id;
                          var bookcard = dataset[index].attributes;
                          var book = dataset[index];
                          return Slidable(
                            key: ValueKey(bookid),
                            startActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                dismissible: DismissiblePane(onDismissed: () {
                                  setState(() {});
                                }),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddandEditBook(
                                                    isUpdate: true,
                                                    isCreate: true,
                                                    //book: book.data![index],
                                                    book: book,
                                                    bookid: bookid,
                                                  )));
                                      // if (result == true) {
                                      //   setState(() {
                                      //     dataUpdate = result;
                                      //     print('result = $result');
                                      //   });
                                      //   print('data = $dataUpdate');
                                      // }
                                    },
                                    label: 'Edit',
                                    backgroundColor: Colors.amber,
                                    icon: Icons.edit,
                                  ),
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
                                                  // ChangeNotifierProvider.value(
                                                  //   value: bookViewModel,
                                                  //   child:
                                                  //       Consumer<BookViewModel>(
                                                  //           builder: (context,
                                                  //               viewModel, _) {
                                                  //     print("Index : ${index}");
                                                  //     return
                                                  TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          bookViewModel
                                                              .deleteBook(
                                                                  bookid);
                                                          delete = false;
                                                          // bookViewModel
                                                          //     .deleteBook(
                                                          //         widget
                                                          //             .bookid);
                                                          data.removeAt(index);
                                                          dataset
                                                              .removeAt(index);
                                                          Navigator.of(context)
                                                              .pop();
                                                        });
                                                        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LibraryScreen()  ));
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
                                  )
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
                        });
                  }else{
                      return const Center(
                  child: Text('Author don\'t have any Books',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color:Appcolor.nbcolor),),
                );
                  }
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
}
