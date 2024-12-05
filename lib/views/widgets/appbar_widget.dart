import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  // implements PreferredSizeWidget yaparak appbarın boyutunu belirleyebilir ve kullanabilirz
  final String title;
  final bool transparent;
  const AppbarWidget(
      {super.key, required this.title, this.transparent = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: transparent ? Colors.transparent : null,
      title: Text(
        title,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
      ),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
