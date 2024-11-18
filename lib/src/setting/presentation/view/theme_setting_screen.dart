import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/presentation/theme_shared_prefs/theme_shared_prefs_cubit.dart';

enum ThemeValue { system, light, dark }

class ThemeSettingScreen extends StatelessWidget {
  const ThemeSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ThemeSharedPrefsCubit, ThemeSharedPrefsState>(
          builder: (context, state) {
            ThemeMode? themeMode;

            switch (state.themeMode) {
              case 0:
                themeMode = ThemeMode.system;
                break;
              case 1:
                themeMode = ThemeMode.light;
                break;
              case 2:
                themeMode = ThemeMode.dark;
                break;
              default:
            }
            return Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const BackButton(),
                      Text(
                        'Tampilan Tema',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  title: const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text('System'),
                  ),
                  selected: state.themeMode == 0,
                  onTap: () =>
                      context.read<ThemeSharedPrefsCubit>().writeThemeMode(0),
                  trailing: Radio<ThemeMode>(
                    value: ThemeMode.system,
                    groupValue: themeMode,
                    onChanged: (value) =>
                        context.read<ThemeSharedPrefsCubit>().writeThemeMode(0),
                  ),
                ),
                const Divider(height: 0, endIndent: 10, indent: 10),
                ListTile(
                  title: const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text('Light'),
                  ),
                  selected: state.themeMode == 1,
                  onTap: () =>
                      context.read<ThemeSharedPrefsCubit>().writeThemeMode(1),
                  trailing: Radio<ThemeMode>(
                    value: ThemeMode.light,
                    groupValue: themeMode,
                    onChanged: (value) =>
                        context.read<ThemeSharedPrefsCubit>().writeThemeMode(1),
                  ),
                ),
                const Divider(height: 0, endIndent: 10, indent: 10),
                ListTile(
                  title: const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text('Dark'),
                  ),
                  selected: state.themeMode == 2,
                  onTap: () =>
                      context.read<ThemeSharedPrefsCubit>().writeThemeMode(2),
                  trailing: Radio<ThemeMode>(
                    value: ThemeMode.dark,
                    groupValue: themeMode,
                    onChanged: (value) =>
                        context.read<ThemeSharedPrefsCubit>().writeThemeMode(2),
                  ),
                ),
                const Divider(height: 0, endIndent: 10, indent: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}
