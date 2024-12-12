import 'package:flutter/material.dart';
import 'package:rickandmorty/models/location_model.dart';
import 'package:rickandmorty/views/widgets/appbar_widget.dart';

class ResidentView extends StatelessWidget {
  final LocationItem? locationItem;
  const ResidentView({super.key, this.locationItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: locationItem!.name.toString()),
      body: Center(
        child: Text(locationItem!.name.toString()), 
      ),
    );
  }
}
