// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rickandmorty/app/getit.dart';
import 'package:rickandmorty/app/router.dart';
import 'package:rickandmorty/models/characters_model.dart';

import '../../services/preferences_service.dart';

class CharacterCardWidget extends StatefulWidget {
  bool isFavorited;
  final CharacterModel characterModel;
  CharacterCardWidget({
    super.key,
    required this.characterModel,
    required this.isFavorited,
  });

  @override
  State<CharacterCardWidget> createState() => _CharacterCardWidgetState();
}

class _CharacterCardWidgetState extends State<CharacterCardWidget> {
  void _favoriteCharacter() {
    if (widget.isFavorited) {
      locator<PreferencesService>().removeCharacters(widget.characterModel.id);
      widget.isFavorited = false;
    } else {
      locator<PreferencesService>().saveCharacters(widget.characterModel.id);
      widget.isFavorited = true;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.characterProfile,
          extra: widget.characterModel),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
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
                      widget.characterModel.image,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  SizedBox(width: 17),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.characterModel.name,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 5),
                      _infoWidget(
                          type: "Köken",
                          value: widget.characterModel.location.name),
                      SizedBox(height: 3),
                      _infoWidget(
                          type: "Durum",
                          value:
                              '${widget.characterModel.status} - ${widget.characterModel.species}'),
                    ],
                  )
                ],
              ),
            ),
            IconButton(
              onPressed: _favoriteCharacter,
              icon: Icon(
                  widget.isFavorited ? Icons.bookmark : Icons.bookmark_border),
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
