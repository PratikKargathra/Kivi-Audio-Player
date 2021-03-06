import 'package:flutter/material.dart';
import 'pages/sorces/sources.dart';

bool isDark = false;

void main(){
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/":(context) => const Homepage(),
        "player":(context) => const AppMusicPlayer(),
      },
    );
  }
}
