import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:librarybook/provider/author.dart';
import 'package:librarybook/provider/book.dart';
import 'package:librarybook/res/constants/app_color.dart';
import 'package:librarybook/res/my_http_override.dart';
import 'package:librarybook/viewmodels/author_viewmodel.dart';
import 'package:librarybook/views/pages/main_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
  HttpOverrides.global = MyhttpOverride();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.black));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthorViewModel()),
        ChangeNotifierProvider.value(value: Author()),
        ChangeNotifierProvider.value(value: Book()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Librarybook',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.transparent,
          primary: Colors.black,
        )),
        home: const SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context)
          .pushReplacement(CupertinoPageRoute(builder: (ctx) => MainPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(
                image: AssetImage("assets/images/gubook.png"),
              ),
              SizedBox(
                height: 100,
              ),
              SpinKitFadingCube(
                color: Appcolor.nbcolor,
                size: 50,
              )
            ]),
      ),
    );
  }
}
