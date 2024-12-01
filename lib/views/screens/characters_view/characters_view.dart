// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/app/router.dart';
import 'package:rickandmorty/views/screens/characters_view/characters_viewmodel.dart';
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
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            children: [
              _searchInputWidget(context),
              Consumer<CharactersViewModel>(builder: (context, ref, child) {
                if (ref.charactersModel == null) {
                  return CircularProgressIndicator.adaptive();
                } else {
                  return Flexible(
                    child: ListView.builder(
                      itemCount: ref.charactersModel!.characters.length,
                      itemBuilder: (context, index) {
                        final charactersIndex =
                            ref.charactersModel!.characters[index];
                        return CharacterCardWidget(
                          characterModel: charactersIndex,
                        );
                      },
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchInputWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 16),
      child: TextField(
        decoration: InputDecoration(
          label: Text("Karakterlerde Ara"),
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
          suffixIcon: Icon(Icons.more_vert),
        ),
      ),
    );
  }
}
