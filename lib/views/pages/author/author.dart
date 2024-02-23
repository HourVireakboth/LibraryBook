import 'package:flutter/material.dart';
import 'package:librarybook/models/authormodel.dart';
import 'package:librarybook/models/bookmodel.dart';
import 'package:librarybook/provider/author.dart';
import 'package:librarybook/views/pages/author/add_edit_author.dart';
import 'package:librarybook/views/pages/author/widgets/author_card2.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../data/response/status.dart';
import '../../../res/constants/app_color.dart';
import '../../../viewmodels/author_viewmodel.dart';
import '../library/add_edit_book.dart';
import '../main_page.dart';

class AuthorScreen extends StatefulWidget {
  AuthorScreen({super.key, this.isUpdate});
  var isUpdate;

  @override
  State<AuthorScreen> createState() => AuthorScreenState();
}

class AuthorScreenState extends State<AuthorScreen> {
  var authorviewModel = AuthorViewModel();
  @override
  void initState() {
    authorviewModel.getAllAuthor();
    super.initState();
  }

  int rebuild = 0;
  bool add = false;
  @override
  Widget build(BuildContext context) {
    // final author1 = Provider.of<AuthorViewModel>(context);
    //  final author2 = Provider.of<author>(context);
    print("rebuild=${rebuild++}");
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
        centerTitle: true,
        title: const Text('Authors'),
        titleSpacing: 0,
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
                          return AddandEditAuthor(
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
      body: ChangeNotifierProvider(
        create: (context) => authorviewModel,
        child: Consumer2<AuthorViewModel, Author>(
          builder: (context, viewModel, author, _) {
            switch (viewModel.apiResponse.status) {
              case Status.LOADING:
                return Center(
                  child: Lottie.network(
                    'https://assets4.lottiefiles.com/packages/lf20_hwm68tlm.json',
                    fit: BoxFit.cover,
                  ),
                );
              case Status.COMPLETED:
                //var author = viewModel.apiResponse.data;
                // data.addAll(viewModel.apiResponse.data!.data!);
                if (add == false) {
                  author.addAuthor(viewModel.apiResponse.data.data!.toList());
                    add = true;
                }
                // print("list Author = ${authorviewModel.items.length}");
                //final datas = viewModel.items;
                // print("date${data}");

                return SizedBox(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: author.items.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15),
                    itemBuilder: (context, index) {
                      return CardAuthor(
                        author: author.items[index],
                        authorid: author.items[index].id,
                        index: index,
                      );
                    },
                  ),
                );
              case Status.ERROR:
                return Text(viewModel.apiResponse.message.toString());
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
    );
  }
}
