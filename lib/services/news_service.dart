import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:news_provider_app/models/category_model.dart';
import '../models/news_response.dart';

// const _country = "us";
// const _urlNews = 'newsapi.org/v2';
// const _apiKey = 'aa436602280541b78295812b78d6f489';
// const _endpoint = '/top-headlines';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  NewsService() {
    getTopHeadlines();
  }

  getTopHeadlines() async {
    const url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=aa436602280541b78295812b78d6f489';

    final resp = await http.get(Uri.parse(url));
    final newsResponse = NewsResponse.fromJson(resp.body);

    headlines.addAll(newsResponse.articles);

    print(headlines);

    notifyListeners();
  }
}
