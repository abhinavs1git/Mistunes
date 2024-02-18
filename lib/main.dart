import 'package:flutter/material.dart';
import 'package:mistunes/models/playlist_provider.dart';
import 'package:mistunes/pages/home_page.dart';
import 'package:mistunes/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=>ThemeProvider()),
      ChangeNotifierProvider(create: (context)=>PlayListProvider()),

    ],
    child: const MyApp(),),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
     home: const  HomePage(),
     theme: Provider.of<ThemeProvider>(context).themeData,

    );
  }
}
