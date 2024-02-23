import 'package:flutter/material.dart';
import 'package:librarybook/data/response/status.dart';
import 'package:librarybook/res/constants/app_color.dart';
import 'package:librarybook/viewmodels/searchbook_viewmodel.dart';
import 'package:librarybook/views/pages/search/widgets/search_card.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../library/widgets/lirbray_book_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchBookViewModel = SearchBookViewModel();
  var search = TextEditingController();

  @override
  void initState() {
    searchBookViewModel = SearchBookViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.bgcolor,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Appcolor.bgcolor,
          title: const Text('Search Books'),
          titleTextStyle: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black)),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            onSubmitted: (value) {
              search.text = value;
              searchBookViewModel.searchBooks(search.text);
              print('search value :${search.text}');
            },
            autofocus: true,
            controller: search,
            decoration: InputDecoration(
              filled: true,
              fillColor: Appcolor.bgcolor,
              prefixIcon: IconButton(
                onPressed: () {
                  var searchs = search.text;
                  searchBookViewModel.searchBooks(searchs.toString());
                  print('search value :$searchs');
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
              helperText: '',
              hintText: 'Search',
              contentPadding: const EdgeInsets.all(15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  search.clear();
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        Expanded(
            child: ChangeNotifierProvider(
          create: (context) => searchBookViewModel,
          child: Consumer<SearchBookViewModel>(
            builder: (context, booksearch, _) {
              switch (booksearch.apiResponse.status) {
                case Status.LOADING:
                  return Center(
                    child: Lottie.network(
                      'https://assets2.lottiefiles.com/packages/lf20_j3gumpgp.json',
                      fit: BoxFit.cover,
                    ),
                  );
                case Status.COMPLETED:
                  var books = booksearch.apiResponse.data!;
                  var bookcount = booksearch.apiResponse.data!.data!.length;
                  return bookcount > 0 ? ListView.builder(
                      itemCount: books.data!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return SearchBookCard(book: books.data![index]);
                      }):Center(
                                    child: Lottie.network(
                                      'https://assets5.lottiefiles.com/private_files/lf30_rpwqbj8q.json',
                                      fit: BoxFit.cover,
                                    ),
                                  );
                case Status.ERROR:
                  return const Center(
                    child: Text('Error'),
                  );
                default:
                  return const Center(
                    child: Text('Please search your book by title here'),
                  );
              }
            },
          ),
        ))
      ]),
    );
  }
}
