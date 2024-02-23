import 'package:flutter/material.dart';
import 'package:librarybook/views/pages/author/add_edit_author.dart';
import 'package:librarybook/views/pages/author/author.dart';
import 'package:librarybook/views/pages/library/add_edit_book.dart';
import 'package:librarybook/views/pages/library/library_screen.dart';
import 'package:librarybook/views/pages/profile/profile_screen.dart';
import 'package:librarybook/views/pages/search/search_screen.dart';
import '../../res/constants/app_color.dart';
import 'home/home_screen.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key, isUpdate});
  int? isUpdate;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentTab = 0;
  var screens = [
    const HomeScreen(),
    LibraryScreen(),
    const SearchScreen(),
     AuthorScreen()
  ];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Appcolor.nbcolor.withOpacity(0.5),
        key: scaffoldKey,
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Appcolor.nbcolor,
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  decoration: const BoxDecoration(
                      color: Appcolor.bgcolor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: double.infinity,
                  padding: const EdgeInsets.all(0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Appcolor.nbcolor)),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddandEditAuthor(isUpdate: false,isCreate: false,)),
                                  (route) => false);
                            },
                            icon: const Icon(Icons.people),
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [Text('ADD NEW AUTHOR')],
                            )),
                        ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Appcolor.nbcolor)),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (_) {
                                return AddandEditBook(
                                  isUpdate: false,
                                  isCreate: false,
                                );
                              }), (route) => false);
                            },
                            icon: const Icon(Icons.book),
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [Text('ADD NEW BOOK')],
                            ))
                      ]),
                );
              },
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
            );
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Appcolor.bgcolor,
          elevation: 0,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: SizedBox(
            height: 60,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            currentTab = 0;
                            currentScreen = const HomeScreen();
                          });
                        },
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.home,
                                  color: currentTab == 0
                                      ? Appcolor.nbcolor
                                      : Appcolor.fixcolor.withOpacity(0.5)),
                              Text(
                                'Home',
                                style: TextStyle(
                                    color: currentTab == 0
                                        ? Appcolor.nbcolor
                                        : Appcolor.fixcolor.withOpacity(0.5)),
                              )
                            ]),
                      ),
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            currentTab = 1;
                            currentScreen = LibraryScreen();
                          });
                        },
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.book,
                                  color: currentTab == 1
                                      ? Appcolor.nbcolor
                                      : Appcolor.fixcolor.withOpacity(0.5)),
                              Text(
                                'Library',
                                style: TextStyle(
                                    color: currentTab == 1
                                        ? Appcolor.nbcolor
                                        : Appcolor.fixcolor.withOpacity(0.5)),
                              )
                            ]),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            currentTab = 2;
                            currentScreen =  AuthorScreen();
                          });
                        },
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.people,
                                  color: currentTab == 2
                                      ? Appcolor.nbcolor
                                      : Appcolor.fixcolor.withOpacity(0.5)),
                              Text(
                                'Author',
                                style: TextStyle(
                                    color: currentTab == 2
                                        ? Appcolor.nbcolor
                                        : Appcolor.fixcolor.withOpacity(0.5)),
                              )
                            ]),
                      ),
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            currentTab = 3;
                            currentScreen = const SearchScreen();
                          });
                        },
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search_off_sharp,
                                  color: currentTab == 3
                                      ? Appcolor.nbcolor
                                      : Appcolor.fixcolor.withOpacity(0.5)),
                              Text(
                                'Search',
                                style: TextStyle(
                                    color: currentTab == 3
                                        ? Appcolor.nbcolor
                                        : Appcolor.fixcolor.withOpacity(0.5)),
                              )
                            ]),
                      ),
                    ],
                  )
                ]),
          ),
        ));
  }
}
