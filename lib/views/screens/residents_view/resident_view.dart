import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/models/location_model.dart';
import 'package:rickandmorty/views/screens/residents_view/resident_viewmodel.dart';
import 'package:rickandmorty/views/widgets/appbar_widget.dart';
import 'package:rickandmorty/views/widgets/character_card_listview_widget.dart';

class ResidentView extends StatefulWidget {
  final LocationItem? locationItem;
  const ResidentView({super.key, this.locationItem});

  @override
  State<ResidentView> createState() => _ResidentViewState();
}

class _ResidentViewState extends State<ResidentView> {
  @override
  void initState() {
    super.initState();
    context
        .read<ResidentViewmodel>()
        .getAllResidents(widget.locationItem!.residents);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: widget.locationItem!.name.toString()),
      body: Center(
        child: Column(
          children: [
            Consumer<ResidentViewmodel>(
              builder: (context, viewModel, child) {
                return CharacterCardListViewWidget(
                    characters: viewModel.residents);
              },
            )
          ],
        ),
      ),
    );
  }
}
