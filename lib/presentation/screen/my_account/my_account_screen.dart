import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../di/injection.dart';
import '../../design_system/theme/app_theme.dart';
import '../../routes/routes.dart';
import 'cubit/my_account_cubit.dart';
import 'cubit/my_account_state.dart';
import 'widgets/account_header.dart';
import 'widgets/logout_confirmation_sheet.dart';
import 'widgets/menu_item_tile.dart';
import 'widgets/selection_sheet.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MyAccountCubit>()..getUserDetails(),
      child:  _MyAccountScreen(),
    );
  }
}

class _MyAccountScreen extends StatefulWidget {
  const _MyAccountScreen();

  @override
  State<_MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<_MyAccountScreen> {
  String _selectedLanguage = 'English';
  String _selectedTheme = 'Light';

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Scaffold(
      backgroundColor: theme.colors.surface,
      body: SafeArea(
        child: BlocBuilder<MyAccountCubit, MyAccountState>(
          builder: (context, state) {
            if (state is AccountLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AccountError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: TextStyle(color: theme.colors.errorVariant),
                ),
              );
            } else if (state is AccountLoaded) {
              final user = state.user;
              return SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AccountHeader(
                      title: 'My Account',
                      name: user.name,
                      email: user.email,
                      bio: user.bio ?? '',
                      imageUrl: user.profileImageUrl,
                    ),
                    _buildMenuSection(theme),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget _buildMenuSection(AppTheme theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          MenuItemTile(
            assetPath: 'assets/images/user-circle-02.svg',
            iconBackgroundColor: theme.colors.blueVariant,
            title: 'Account informations',
            onTap: () {},
          ),
          MenuItemTile(
            assetPath: 'assets/images/lock-sync-02.svg',
            iconBackgroundColor: theme.colors.blueVariant,
            title: 'Change password',
            onTap: () {},
          ),
          MenuItemTile(
            assetPath: 'assets/images/location-star-01.svg',
            iconBackgroundColor: theme.colors.secondaryVariant,
            title: 'Saved Locations',
            onTap: () {},
          ),
          MenuItemTile(
            assetPath: 'assets/images/all-bookmark.svg',
            iconBackgroundColor: theme.colors.yellowVariant,
            title: 'Saved Workspaces',
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.savedWorkspaces,
              );
            },
          ),
          MenuItemTile(
            assetPath: 'assets/images/sun-02.svg',
            iconBackgroundColor: theme.colors.blueVariant,
            title: 'App Theme',
            trailing: _selectedTheme,
            onTap: () => _showThemeBottomSheet(context),
          ),
          MenuItemTile(
            assetPath: 'assets/images/language-circle.svg',
            iconBackgroundColor: theme.colors.secondaryVariant,
            title: 'App Language',
            trailing: _selectedLanguage,
            onTap: () => _showLanguageBottomSheet(context),
          ),
          MenuItemTile(
            assetPath: 'assets/images/customer-support.svg',
            iconBackgroundColor: theme.colors.secondaryVariant,
            title: 'Need help?',
            trailing: 'contact with us',
            onTap: () {},
          ),
          MenuItemTile(
            assetPath: 'assets/images/mobile-programming-02.svg',
            iconBackgroundColor: theme.colors.blueVariant,
            title: 'App Versions',
            onTap: () {},
          ),
          MenuItemTile(
            assetPath: 'assets/images/logout-05.svg',
            iconBackgroundColor: theme.colors.errorVariant,
            title: 'Logout',
            onTap: () => _showLogoutConfirmation(context),
          ),
        ],
      ),
    );
  }

  Future<void> _showLanguageBottomSheet(BuildContext context) async {
    final selected = await SelectionSheet.show<String>(
      context: context,
      title: 'App Language',
      initialValue: _selectedLanguage,
      options: [
        SelectionSheetOption<String>(
          value: 'English',
          label: 'English',
          leadingBuilder: (context, isSelected) =>
              SelectionSheetBadge.text(text: 'A', highlighted: isSelected),
        ),
        SelectionSheetOption<String>(
          value: 'Arabic',
          label: 'Arabic',
          leadingBuilder: (context, isSelected) =>
              SelectionSheetBadge.text(text: 'ع', highlighted: isSelected),
        ),
      ],
      horizontalMargin: 0,
    );

    if (selected != null && selected != _selectedLanguage) {
      setState(() => _selectedLanguage = selected);
    }
  }

  Future<void> _showThemeBottomSheet(BuildContext context) async {
    final selected = await SelectionSheet.show<String>(
      context: context,
      title: 'App Theme',
      initialValue: _selectedTheme,
      options: [
        SelectionSheetOption<String>(
          value: 'Light',
          label: 'Light',
          leadingBuilder: (context, isSelected) => SelectionSheetBadge(
            highlighted: isSelected,
            child: Icon(
              Icons.wb_sunny_rounded,
              color: isSelected
                  ? AppTheme.of(context).colors.onPrimary
                  : AppTheme.of(context).colors.primary,
            ),
          ),
        ),
        SelectionSheetOption<String>(
          value: 'Dark',
          label: 'Dark',
          leadingBuilder: (context, isSelected) => SelectionSheetBadge(
            highlighted: isSelected,
            child: Icon(
              Icons.nightlight_round,
              color: isSelected
                  ? AppTheme.of(context).colors.onPrimary
                  : AppTheme.of(context).colors.primary,
            ),
          ),
        ),
      ],
      horizontalMargin: 0,
    );

    if (selected != null && selected != _selectedTheme) {
      setState(() => _selectedTheme = selected);
    }
  }

  Future<void> _showLogoutConfirmation(BuildContext context) async {
    final shouldLogout = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => LogoutConfirmationSheet(
        onConfirm: () => Navigator.of(context).pop(true),
      ),
    );

    if (shouldLogout == true) {
      debugPrint('User confirmed logout');
      await context.read<MyAccountCubit>().logout();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isLoggedIn", false);

      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.loginScreen,
              (route) => false,
        );
      }
    }
  }
}
