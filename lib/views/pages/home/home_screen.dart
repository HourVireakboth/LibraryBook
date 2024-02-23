import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:librarybook/data/response/status.dart';
import 'package:librarybook/models/bookmodel.dart';
import 'package:librarybook/res/constants/app_color.dart';
import 'package:librarybook/viewmodels/author_viewmodel.dart';
import 'package:librarybook/viewmodels/book_viewmodel.dart';
import 'package:librarybook/views/pages/home/widgets/animated_dots.dart';
import 'package:librarybook/views/pages/home/widgets/author_card.dart';
import 'package:librarybook/views/pages/home/widgets/book_card.dart';
import 'package:librarybook/views/pages/home/widgets/card_slider.dart';
import 'package:librarybook/views/pages/library/library_screen.dart';
import 'package:librarybook/views/pages/search/search_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int activeIndex = 0;
final urlImages = [
  'assets/images/Photo1.jpg',
  'assets/images/Photo2.jpg',
  'assets/images/Photo3.jpg'
];
final urlBooks = [
  'https://static.electronicsweekly.com/wp-content/uploads/2021/10/14135005/Flutter-Apprentice-book.png',
  'https://m.media-amazon.com/images/I/41+l48O6TbL.jpg',
  'https://m.media-amazon.com/images/I/81BROimNPvL.jpg',
  'https://uniqueish.in/wp-content/uploads/2022/07/web-design-with-html-and-css-digital-classroom.png',
  'https://m.media-amazon.com/images/I/41kTCNntE1L.jpg',
  'https://m.media-amazon.com/images/I/71o1wSMSgML._AC_UF1000,1000_QL80_.jpg',
];

class _HomeScreenState extends State<HomeScreen> {
  final bookViewModel = BookViewModel();
  final authorViewModel = AuthorViewModel();
  @override
  void initState() {
    bookViewModel.getAllBooks();
    authorViewModel.getAllAuthor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Appcolor.bgcolor,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Appcolor.bgcolor,
          titleTextStyle: const TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
          title: const Text('Gubooks'),
          actions: [
            Container(
              padding: const EdgeInsets.only(left: 50, right: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return const SearchScreen();
                        }));
                        print('go to Search');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 180,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Appcolor.fixcolor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Search books...')),
                              ),
                            ),
                            Positioned(
                                top: -5,
                                right: -1,
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Appcolor.nbcolor,
                                    ),
                                    child: const Icon(
                                      Icons.search_sharp,
                                      color: Appcolor.bgcolor,
                                    )))
                          ],
                        ),
                      ),
                    )
                  ]),
            ),
          ]),
      body: ChangeNotifierProvider(
        create: (context) => bookViewModel,
        child: Consumer<BookViewModel>(
          builder: (context, viewModel, _) {
            var status = viewModel.apiResponse.status;
            switch (status) {
              case Status.LOADING:
                return Center(
                    child: Lottie.network(
                      'https://assets10.lottiefiles.com/packages/lf20_a2chheio.json',
                      fit: BoxFit.cover,
                    ));
              case Status.COMPLETED:
                var book = viewModel.apiResponse.data!;
                print('count item :${book.data!.length}');
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 0),
                        height: size.height * 0.23,
                        child: CarouselSlider.builder(
                            itemCount: urlImages.length,
                            itemBuilder: (context, index, realIndex) {
                              final urlImage = urlImages[index];
                              return CardSlider(urlImage: urlImage);
                            },
                            options: CarouselOptions(
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 2),
                                aspectRatio: 2.5,
                                enlargeCenterPage: true,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    activeIndex = index;
                                  });
                                })),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Center(
                        child: SizedBox(
                          height: 20,
                          child: AnimatedSmoothDots(
                            activeIndex: activeIndex,
                            urlImages: urlImages,
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 20, left: 20, bottom: 20),
                        child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Popular This Month',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return LibraryScreen();
                                      }));
                                    },
                                    child: const Text(
                                      'See more..',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: Appcolor.fixcolor),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: SizedBox(
                            height: size.height * 0.36,
                            child: ListView.builder(
                                itemCount: book.data!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return BookCard(
                                    book: book.data![index],
                                  );
                                }))),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, bottom: 20),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Most Populer Author',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w700),
                            )),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ChangeNotifierProvider(
                        create: (context) => authorViewModel,
                        child: Consumer<AuthorViewModel>(
                          builder: (context, viewModel, _) {
                            switch (viewModel.apiResponse.status) {
                              case Status.LOADING:
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              case Status.COMPLETED:
                                var author = viewModel.apiResponse.data;
                                return SizedBox(
                                    height: size.height * 0.20,
                                    child: ListView.builder(
                                        itemCount: author?.data.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return AuthorCard(
                                            author: author?.data[index],
                                          );
                                        }));
                              case Status.ERROR:
                                return Text(viewModel.apiResponse.message
                                    .toString());
                              default:
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                            }
                          },
                        ),
                      ),
                    )
                  ],
                );
              case Status.ERROR:
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
