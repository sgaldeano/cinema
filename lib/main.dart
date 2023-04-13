import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s7_cinema/router/routes.dart';
import 'providers/providers.dart' show MoviesProvider;

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {

  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false)
      ],
      child: const MyApp()
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cinema',
      initialRoute: 'home',
      routes: Routes.routes,
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color: Colors.black87
        )
      )
    );
  }
}