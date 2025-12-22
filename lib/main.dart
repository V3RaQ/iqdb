import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iqdb/Config/Colors.dart';
import 'package:iqdb/View/Home%20Page/HomePage.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.robotoSlab(
            color: Colors.white
          )
        )
      ),
      home: HomePage(),
    );
  }
}
