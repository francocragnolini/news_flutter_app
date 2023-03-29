import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:news_provider_app/models/category_model.dart';
import '../models/news_response.dart';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];

  String _selectedCategory = "business";
  // tab2 - icons - listview-builder
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  // constructor -para realizar el fetch a la api apenas se inicializa la aplicacion
  NewsService() {
    getTopHeadlines();

    categories.forEach((item) {
      categoryArticles[item.name] = [];
    });
    getArticlesByCategory(_selectedCategory);
  }

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String value) {
    _selectedCategory = value;

    notifyListeners();
  }

  List<Article>? get getArticulosCategoriaSeleccionada =>
      categoryArticles[selectedCategory];

  // get a list of general articles
  getTopHeadlines() async {
    const url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=aa436602280541b78295812b78d6f489';

    final resp = await http.get(Uri.parse(url));
    final newsResponse = NewsResponse.fromJson(resp.body);

    headlines.addAll(newsResponse.articles);

    log('$headlines');

    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      notifyListeners();
      return categoryArticles[category];
    }

    final url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=aa436602280541b78295812b78d6f489&category=$category';

    final resp = await http.get(Uri.parse(url));

    final newsResponse = NewsResponse.fromJson(resp.body);

    categoryArticles[category]!.addAll(newsResponse.articles);

    notifyListeners();
  }
}
