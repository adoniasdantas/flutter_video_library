import 'package:flutter/material.dart';

import '../pages/episode_page.dart';
import '../pages/favorites_page.dart';
import '../pages/home_page.dart';
import '../pages/person_page.dart';
import '../pages/search_people.dart';
import '../pages/tv_show_page.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case AppRoutes.searchPeoplePage:
        return MaterialPageRoute(builder: (_) => const SearchPeoplePage());

      case AppRoutes.tvShowPage:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => TvShowPage(
              id: args,
            ),
          );
        }

        return _errorRoute();

      case AppRoutes.episodePage:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => EpisodePage(
              id: args,
            ),
          );
        }
        return _errorRoute();

      case AppRoutes.personPage:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => PersonPage(
              id: args,
            ),
          );
        }
        return _errorRoute();

      case AppRoutes.favoritesPage:
        return MaterialPageRoute(builder: (_) => const FavoritesPage());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
