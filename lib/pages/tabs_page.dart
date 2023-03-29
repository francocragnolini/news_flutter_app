import 'package:flutter/material.dart';
import 'package:news_provider_app/pages/tab1_page.dart';
import 'package:news_provider_app/pages/tab2_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: const Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavigationModel>(context);
    return PageView(
      // physics: const BouncingScrollPhysics(),
      physics: const NeverScrollableScrollPhysics(),
      controller: navegacionModel.pageController,
      children: const [
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (value) {
        navegacionModel.paginaActual = value;
      },
      items: const [
        BottomNavigationBarItem(
          label: "Para ti",
          icon: Icon(Icons.person_outline),
        ),
        BottomNavigationBarItem(
          label: "Encabezados",
          icon: Icon(Icons.public),
        ),
      ],
    );
  }
}

class _NavigationModel extends ChangeNotifier {
  // modificacion del iindex del BottonNavigationBar
  int _paginaActual = 0;

  // coordinar el index del BottonNavigationBar con el  PageView
  PageController _pageController = PageController(initialPage: 0);

  int get paginaActual => _paginaActual;

  PageController get pageController => _pageController;

  set paginaActual(int value) {
    _paginaActual = value;

    // se le asigna el  mismo value(index) al pageController
    _pageController.animateToPage(value,
        curve: Curves.easeIn, duration: const Duration(milliseconds: 250));
    notifyListeners();
  }
}
