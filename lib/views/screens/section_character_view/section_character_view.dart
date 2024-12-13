import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/models/episodes_model.dart';
import 'package:rickandmorty/models/location_model.dart';
import 'package:rickandmorty/views/screens/residents_view/resident_viewmodel.dart';
import 'package:rickandmorty/views/screens/section_character_view/section_character_viewmodel.dart';
import 'package:rickandmorty/views/widgets/appbar_widget.dart';
import 'package:rickandmorty/views/widgets/character_card_listview_widget.dart';

class SectionCharacterView extends StatefulWidget {
  final EpisodesModel? locationItem;
  const SectionCharacterView({super.key, this.locationItem});

  @override
  State<SectionCharacterView> createState() => _SectionCharacterViewState();
}

class _SectionCharacterViewState extends State<SectionCharacterView> {
  @override
  void initState() {
    super.initState();
    context
        .read<SectionCharacterViewmodel>()
        .getCharacters(widget.locationItem!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: widget.locationItem!.name.toString()),
      body: Center(
        child: Column(
          children: [
            Consumer<SectionCharacterViewmodel>(
                builder: (context, viewModel, child) {
              return CharacterCardListViewWidget(
                  characters: viewModel.characters);
            })
          ],
        ),
      ),
    );
  }
}
