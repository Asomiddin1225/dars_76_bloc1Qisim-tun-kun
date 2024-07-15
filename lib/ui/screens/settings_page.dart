import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dars_74/cubit/theme_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: Text('Dark Mode'),
            value: themeCubit.state,
            onChanged: (bool value) {
              themeCubit.toggleTheme();
            },
          ),
        ],
      ),
    );
  }
}
