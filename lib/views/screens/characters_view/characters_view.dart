// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/app/router.dart';
import 'package:rickandmorty/views/screens/characters_view/characters_viewmodel.dart';
import 'package:rickandmorty/views/widgets/appbar_widget.dart';
import 'package:rickandmorty/views/widgets/character_card_listview_widget.dart';
import 'package:rickandmorty/views/widgets/character_card_widget.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  @override
  void initState() {
    super.initState();
    context.read<CharactersViewModel>().getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CharactersViewModel>();
    return Scaffold(
      appBar: AppbarWidget(title: "Rick and Morty"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            children: [
              _searchInputWidget(context, viewModel: viewModel),
              viewModel.charactersModel == null
                  ? CircularProgressIndicator.adaptive()
                  : CharacterCardListViewWidget(
                      characters: viewModel.charactersModel!.characters,
                      onLoadMore: viewModel.getCharactersMore,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchInputWidget(BuildContext context,
      {required CharactersViewModel viewModel}) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 16),
      child: TextFormField(
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (value) => viewModel.getCharactersByName(value),
        decoration: InputDecoration(
          label: Text("Karakterlerde Ara"),
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
          suffixIcon: PopupMenuButton(
            onSelected:
                context.read<CharactersViewModel>().getCharactersByStatus,
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) {
              return CharacterType.values
                  .map(
                    (e) => PopupMenuItem(
                      value: e,
                      child: Text(e.name),
                    ),
                  )
                  .toList();
            },
          ),
        ),
      ),
    );
  }
}
