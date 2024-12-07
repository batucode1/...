import 'package:flutter/material.dart';

class DecorationContainer extends StatelessWidget {
  final Widget child;
  final Widget topChild;
  const DecorationContainer(
      {super.key, required this.child, required this.topChild});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/bg-image.png'),
            alignment: Alignment.topCenter,
            fit: BoxFit.fitWidth),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          topChild,
          Expanded(
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                ),
                child: child),
          ),
        ],
      ),
    );
  }
}
