import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/app/router.dart';
import 'package:rickandmorty/views/screens/favourites_view/favourites_viewmodel.dart';
import 'package:rickandmorty/views/widgets/character_card_listview_widget.dart';

class FavouritesView extends StatefulWidget {
  const FavouritesView({super.key});

  @override
  State<FavouritesView> createState() => _FavouritesViewState();
}

class _FavouritesViewState extends State<FavouritesView> {
  @override
  void initState() {
    super.initState();
    context.read<FavouritesViewmodel>().getFavourites();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FavouritesViewmodel>();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(5),
        child: viewModel.charactersModel == null
            ? Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : viewModel.charactersModel!.isEmpty
                ? Center(
                    child: Text('No favourites added'),
                  )
                : Column(
                    children: [
                      CharacterCardListViewWidget(
                        characters: viewModel.charactersModel!,
                      )
                    ],
                  ),
      ),
    );
  }
}
