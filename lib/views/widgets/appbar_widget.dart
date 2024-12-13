import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/router.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  // implements PreferredSizeWidget yaparak appbarın boyutunu belirleyebilir ve kullanabilirz
  final String title;
  final bool transparent;
  final bool hideSettings;
  const AppbarWidget(
      {super.key,
      required this.title,
      this.transparent = false,
      this.hideSettings = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: transparent ? Colors.transparent : null,
      title: Text(
        title,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
      ),
      actions: [
        if (!hideSettings)
          IconButton(
              onPressed: () => context.push(AppRoutes.settings),
              icon: Icon(Icons.settings))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
