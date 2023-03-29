import 'package:flutter/material.dart';
import 'package:news_provider_app/services/news_service.dart';
import 'package:news_provider_app/widgets/news_list.dart';
import 'package:provider/provider.dart';

//? statuful widget to keep the scroll (para lograr que cuando regresamos al tab1 mantega el scroll en su posicion )
class Tab1Page extends StatefulWidget {
  const Tab1Page({super.key});

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: newsService.headlines.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListaNoticias(noticias: newsService.headlines),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
