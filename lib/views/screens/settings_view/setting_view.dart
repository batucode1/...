import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/app/theme.dart';
import 'package:rickandmorty/views/widgets/appbar_widget.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        title: "Settings",
        hideSettings: true,
      ),
      body: Center(
        child: ListView(
          children: [
            ListTile(
              title: Text("Karanlık Tema"),
              leading: Switch(
                value: context.watch<AppTheme>().themeMode == ThemeMode.dark,
                onChanged: (v) => context.read<AppTheme>().toogle(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
