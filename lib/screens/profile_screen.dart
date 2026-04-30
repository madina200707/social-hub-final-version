import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../cubits/auth_cubit.dart';
import '../cubits/theme_cubit.dart';
import '../cubits/language_cubit.dart';
import '../app_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) {
        final lang = locale.languageCode;
        final isDark = context.watch<ThemeCubit>().state == ThemeMode.dark;

        return Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.get('profile', lang)),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.green,
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 40,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  user?.email ?? "No email",
                  style: const TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 25),

                ListTile(
                  leading: const Icon(Icons.language),
                  title: Text(AppStrings.get('language', lang)),
                  trailing: DropdownButton<String>(
                    value: lang,
                    items: const [
                      DropdownMenuItem(value: "en", child: Text("EN")),
                      DropdownMenuItem(value: "ru", child: Text("RU")),
                      DropdownMenuItem(value: "kk", child: Text("KZ")),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        context.read<LanguageCubit>().changeLanguage(value);
                      }
                    },
                  ),
                ),

                ListTile(
                  leading: const Icon(Icons.palette),
                  title: Text(AppStrings.get('toggleTheme', lang)),
                  trailing: Switch(
                    value: isDark,
                    activeColor: Colors.green,
                    onChanged: (_) {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                  ),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      context.read<AuthCubit>().logout();
                    },
                    icon: const Icon(Icons.logout),
                    label: Text(AppStrings.get('logout', lang)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
