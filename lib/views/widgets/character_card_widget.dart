// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rickandmorty/models/characters_model.dart';

class CharacterCardWidget extends StatelessWidget {
  final CharacterModel characterModel;
  const CharacterCardWidget({
    super.key,
    required this.characterModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6), // Radius for photo
              child: Image.network(
                characterModel.image,
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(width: 17),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  characterModel.name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                _infoWidget(type: "Köken", value: characterModel.location.name),
                SizedBox(height: 3),
                _infoWidget(
                    type: "Durum",
                    value:
                        '${characterModel.status} - ${characterModel.species}'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Column _infoWidget({required String type, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(type),
        Text(value),
      ],
    );
  }
}
