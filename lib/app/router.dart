import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rickandmorty/views/screens/characters_view/characters.dart';
import 'package:rickandmorty/views/screens/location_view/location_view.dart';
import 'package:rickandmorty/views/screens/section_view/section_view.dart';
import '../views/app_view.dart';
import '../views/screens/favourites_view/favourites_view.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  AppRoutes._(); // this means you can't instantiate this class

  static const String characters = '/';
  static const String locations = '/locations';
  static const String favourites = '/favourites';
  static const String sections = '/sections';
}

final router = GoRouter(
    initialLocation: AppRoutes.characters,
    navigatorKey:
        rootNavigatorKey, // navigatorKey and initialLocation are required for GoRouter to work
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, shellRouteData) => AppView(
          navigationShell: shellRouteData,
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.characters,
                builder: (context, state) => CharactersView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.favourites,
                builder: (context, state) => FavouritesView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.locations,
                builder: (context, state) => LocationView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.sections,
                builder: (context, state) => SectionView(),
              ),
            ],
          ),
        ],
      ),
    ]);
