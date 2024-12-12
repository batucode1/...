import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/models/location_model.dart';
import 'package:rickandmorty/views/screens/characters_view/characters_view.dart';
import 'package:rickandmorty/views/screens/location_view/location_view.dart';
import 'package:rickandmorty/views/screens/location_view/location_viewmodel.dart';
import 'package:rickandmorty/views/screens/residents_view/resident_view.dart';
import 'package:rickandmorty/views/screens/section_view/section_view.dart';
import '../models/characters_model.dart';
import '../views/screens/character_profile_view/character_profile_view.dart';
import '../views/screens/character_profile_view/character_profile_viewmodel.dart';
import '../views/screens/characters_view/characters_viewmodel.dart';
import '../views/app_view.dart';
import '../views/screens/favourites_view/favourites_view.dart';
import '../views/screens/favourites_view/favourites_viewmodel.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  AppRoutes._(); // this means you can't instantiate this class

  static const String characters = '/';
  static const String locations = '/locations';
  static const String favourites = '/favourites';
  static const String sections = '/sections';
  //sub routes
  static const String profileRoute = 'characterProfile';
  //sub routes
  static const String characterProfile = '/characterProfile';

  static const String residentRoute = 'residents';
  static const String residents = '/locations/residents';
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
                builder: (context, state) => ChangeNotifierProvider(
                  create: (context) => CharactersViewModel(),
                  child: const CharactersView(),
                ),
                routes: [
                  GoRoute(
                    path: AppRoutes.profileRoute,
                    builder: (context, state) => ChangeNotifierProvider(
                      create: (context) => CharacterProfileViewmodel(),
                      child: CharacterProfileView(
                          characterModel: state.extra as CharacterModel),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.favourites,
                builder: (context, state) => ChangeNotifierProvider(
                  create: (context) => FavouritesViewmodel(),
                  child: const FavouritesView(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.locations,
                builder: (context, state) => ChangeNotifierProvider(
                    create: (context) => LocationViewmodel(),
                    child: const LocationView()),
                routes: [
                  GoRoute(
                    path: AppRoutes.residentRoute,
                    builder: (context, state) =>
                        ResidentView(locationItem: state.extra as LocationItem),
                  ),
                ],
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
