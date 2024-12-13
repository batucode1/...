// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/views/screens/section_view/section_viewmodel.dart';
import 'package:rickandmorty/views/widgets/appbar_widget.dart';
import 'package:rickandmorty/views/widgets/decoration_container_widget.dart';
import 'package:rickandmorty/views/widgets/episodes_listview.dart';

class SectionView extends StatefulWidget {
  const SectionView({super.key});

  @override
  State<SectionView> createState() => _SectionViewState();
}

class _SectionViewState extends State<SectionView> {
  @override
  void initState() {
    super.initState();
    context.read<SectionViewmodel>().getAllEpisodes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppbarWidget(
              title: 'Section',
              transparent: true,
            ),
            body: DecorationContainer(
              child: Consumer<SectionViewmodel>(
                builder: (context, viewModel, child) {
                  if (viewModel.allEpisodesModel == null) {
                    return CircularProgressIndicator();
                  } else {
                    return EpisodesListview(
                      episodes: viewModel.allEpisodesModel!.episodes,
                      onLoadMore: viewModel.getMoreEpisodes,
                      loadMore: viewModel.loadMore,
                    );
                  }
                },
              ),
              topChild: SizedBox(
                height: 75,
              ),
            )));
  }
}
