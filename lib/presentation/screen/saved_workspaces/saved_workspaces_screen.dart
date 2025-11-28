import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/di/injection.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';
import 'package:share_space/presentation/design_system/widget/custom_app_bar.dart';
import 'package:share_space/presentation/design_system/widget/workspace_details_card.dart';
import 'package:share_space/presentation/screen/saved_workspaces/state/saved_workspaces_cubit.dart';
import 'package:share_space/presentation/screen/saved_workspaces/state/saved_workspaces_state.dart';

import '../../../domain/usecase/workspace/get_saved_workspace.dart';
import '../../design_system/widget/loading_screen.dart';
import '../../routes/routes.dart';
import '../room_details/room_details_arguments.dart';

class SavedWorkspacesScreen extends StatelessWidget {
  const SavedWorkspacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Scaffold(
      backgroundColor: theme.colors.surface,
      body: SafeArea(
        child: BlocProvider(
          create: (_) => SavedWorkspacesCubit(
            getIt<GetSavedWorkspacesUseCase>(),
          )..fetchSavedWorkspaces(),
          child: const _SavedWorkspacesView(),
        ),
      ),
    );
  }
}

class _SavedWorkspacesView extends StatelessWidget {
  const _SavedWorkspacesView();

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppBar(title: 'Saved workspaces'),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<SavedWorkspacesCubit, SavedWorkspacesState>(
              builder: (context, state) {
                if (state is SavedWorkspacesInitial ||
                    state is SavedWorkspacesLoading) {
                  return const LoadingScreen();
                }

                if (state is SavedWorkspacesError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: theme.typography.textTheme.bodyMedium?.copyWith(
                        color: theme.colors.errorVariant,
                      ),
                    ),
                  );
                }

                if (state is SavedWorkspacesEmpty) {
                  return Center(
                    child: Text(
                      'No saved workspaces yet.',
                      style: theme.typography.textTheme.bodyMedium?.copyWith(
                        color: theme.colors.body,
                      ),
                    ),
                  );
                }

                if (state is SavedWorkspacesLoaded) {
                  final workspaces = state.workspaces;

                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: workspaces.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final workspace = workspaces[index];

                      final imageUrl = workspace.imageUrls.isNotEmpty
                          ? workspace.imageUrls.first
                          : '';

                      final pricePerHour =
                          '${workspace.pricePerHour.toStringAsFixed(0)}/h';

                      final amenities =
                      workspace.services.map((s) => s.name).toList();

                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.roomDetailsScreen,
                            arguments: RoomDetailsArguments(
                              roomId: workspace.id,
                              isSaved: true, // ✅ لأنه جاي من قائمة المحفوظات
                            ),
                          );
                        },
                        child: WorkspaceDetailsCard(
                          imageUrl: imageUrl,
                          rating: workspace.rate,
                          title: workspace.name,
                          price: pricePerHour,
                          location: workspace.locationName,
                          amenities: amenities,
                        ),
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
