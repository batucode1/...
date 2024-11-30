// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CharacterCardWidget extends StatelessWidget {
  final String name;
  final String image;
  final String origin;
  final String status;
  final String type;
  const CharacterCardWidget(
      {super.key,
      required this.name,
      required this.image,
      required this.origin,
      required this.status,
      required this.type});

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
                image,
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(width: 17),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                _infoWidget(type: "Köken", value: origin),
                SizedBox(height: 3),
                _infoWidget(type: "Durum", value: status),
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
