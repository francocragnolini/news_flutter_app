import 'package:flutter/material.dart';
import 'package:news_provider_app/pages/tabs_page.dart';
import 'package:news_provider_app/services/news_service.dart';
import 'package:news_provider_app/theme/my_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsService(),
        )
      ],
      child: MaterialApp(
        title: 'News Provider',
        theme: myTheme,
        debugShowCheckedModeBanner: false,
        home: const TabsPage(),
      ),
    );
  }
}
