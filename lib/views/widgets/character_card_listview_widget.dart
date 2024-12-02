// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:rickandmorty/app/getit.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/services/preferences_service.dart';

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
  bool isLoading = true;
  List<int> _favoritedList = [];

  @override
  void initState() {
    getFavList();
    dedectScrollBottom();
    super.initState();
  }

  void setLoading(bool value) {
    isLoading = value;
    setState(() {});
  }

  void getFavList() {
    _favoritedList = locator<PreferencesService>().getSavedCharacters();
    setLoading(false);
    setState(() {});
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
          final bool isFav = _favoritedList.contains(charactersIndex.id);
          return CharacterCardWidget(
              characterModel: charactersIndex, isFavorited: isFav);
        },
      ),
    );
  }
}
