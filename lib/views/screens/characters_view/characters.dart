// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rickandmorty/views/widgets/character_card_widget.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            children: [
              _searchInputWidget(context),
              CharacterCardWidget(
                name: 'Rick Sanchez',
                origin: 'Earth (C-137)',
                image:
                    'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
                status: 'Yaşıyor',
                type: 'İnsan',
              ),
              CharacterCardWidget(
                name: 'Rick Sanchez',
                origin: 'Earth (C-137)',
                image:
                    'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
                status: 'Yaşıyor',
                type: 'İnsan',
              ),
              CharacterCardWidget(
                name: 'Rick Sanchez',
                origin: 'Earth (C-137)',
                image:
                    'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
                status: 'Yaşıyor',
                type: 'İnsan',
              ),
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
