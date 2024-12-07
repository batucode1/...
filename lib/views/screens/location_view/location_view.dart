// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/views/screens/location_view/location_viewmodel.dart';
import 'package:rickandmorty/views/screens/location_view/locations_listview.dart';
import 'package:rickandmorty/views/widgets/decoration_container_widget.dart';

import '../../widgets/appbar_widget.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  @override
  void initState() {
    context.read<LocationViewmodel>().getLocations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const AppbarWidget(
          title: "Location",
          transparent: true,
        ),
        body: Center(
          child: DecorationContainer(
            topChild: const SizedBox(height: 75),
            child: _locationListview(),
          ),
        ),
      ),
    );
  }

  Widget _locationListview() {
    return Container(
      width: double.infinity,
      child: Consumer<LocationViewmodel>(
        builder: (context, viewModel, child) {
          if (viewModel.locationModel == null) {
            return const Center();
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 30),
              child: LocationsListview(
                locationModel: viewModel.locationModel!,
                onLoadMore: viewModel.getMoreLocations,
                moreLoad: viewModel.loadMore,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _subtitleItem({required String text, required String value}) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 10),
        )
      ],
    );
  }
}
