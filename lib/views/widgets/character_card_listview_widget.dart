// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:rickandmorty/models/characters_model.dart';

import 'character_card_widget.dart';

class CharacterCardListViewWidget extends StatefulWidget {
  final List<CharacterModel>
      characters; //liste itemlerini dışarıdan alıp bağımsız bir widget oluşturacagız
  final VoidCallback onLoadMore;

  CharacterCardListViewWidget(
      {super.key, required this.characters, required this.onLoadMore});

  @override
  State<CharacterCardListViewWidget> createState() =>
      _CharacterCardListViewWidgetState();
}

class _CharacterCardListViewWidgetState
    extends State<CharacterCardListViewWidget> {
  final scroller = ScrollController();

  @override
  void initState() {
    dedectScrollBottom();
    super.initState();
  }

  void dedectScrollBottom() {
    scroller.addListener(() {
      final maxScroll = scroller.position.maxScrollExtent;
      final currentScroll = scroller.position.pixels;
      if (maxScroll - currentScroll <= 200) {
        widget.onLoadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        controller: scroller,
        itemCount: widget.characters.length,
        itemBuilder: (context, index) {
          final charactersIndex = widget.characters[index];
          return CharacterCardWidget(
            characterModel: charactersIndex,
          );
        },
      ),
    );
  }
}
