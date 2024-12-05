// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/models/episodes_model.dart';
import 'package:rickandmorty/views/widgets/appbar_widget.dart';

import 'character_profile_viewmodel.dart';

class CharacterProfileView extends StatefulWidget {
  final CharacterModel characterModel;
  const CharacterProfileView({super.key, required this.characterModel});

  @override
  State<CharacterProfileView> createState() => _CharacterProfileViewState();
}

class _CharacterProfileViewState extends State<CharacterProfileView> {
  @override
  void initState() {
    super.initState();
    context
        .read<CharacterProfileViewmodel>()
        .getEpisodes(widget.characterModel.episode);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppbarWidget(
          title: "Karakter Profili",
          transparent: true,
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg-image.png'),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _characterAvatar(context),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(50)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Text(
                        widget.characterModel.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 15),
                      _labelsView(context),
                      SizedBox(height: 40),
                      _episodeTitle(),
                      SizedBox(height: 15),
                      _episodeListview(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _episodeListview() {
    return Flexible(
      child: Consumer<CharacterProfileViewmodel>(
        builder: (context, viewModel, child) => ListView.separated(
          separatorBuilder: (context, index) => Divider(
              endIndent: 40,
              indent: 40,
              color: Theme.of(context).colorScheme.tertiary),
          itemCount: viewModel.episodes.length,
          itemBuilder: (context, index) {
            final EpisodesModel model = viewModel.episodes[index];
            return ListTile(
              leading: Icon(Icons.face_retouching_natural),
              title: Text(
                model.episode,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                model.name,
                style: TextStyle(fontSize: 12),
              ),
            );
          },
        ),
      ),
    );
  }

  Container _episodeTitle() {
    return Container(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          "Bölümler {${widget.characterModel.episode.length}}",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Padding _labelsView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 14,
        runSpacing: 5,
        children: [
          _labelWidget(context, label: widget.characterModel.name),
          _labelWidget(context, label: widget.characterModel.status),
          _labelWidget(context, label: widget.characterModel.species),
          _labelWidget(context, label: widget.characterModel.gender),
        ],
      ),
    );
  }

  Container _labelWidget(BuildContext context, {required String label}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(label),
    );
  }

  Widget _characterAvatar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 90, bottom: 50),
      child: CircleAvatar(
        radius: 100,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: CircleAvatar(
          radius: 98,
          backgroundColor: Theme.of(context).colorScheme.surface,
          child: CircleAvatar(
            backgroundImage: NetworkImage(widget.characterModel.image),
            radius: 95,
          ),
        ),
      ),
    );
  }
}
