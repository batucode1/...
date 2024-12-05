import 'package:flutter/material.dart';
import 'package:rickandmorty/models/characters_model.dart';

class CharacterProfileView extends StatelessWidget {
  final CharacterModel characterModel;
  const CharacterProfileView({super.key, required this.characterModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(characterModel.name),
      ),
    );
  }
}
