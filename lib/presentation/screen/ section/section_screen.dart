import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/presentation/screen/%20section/state/section_cubit.dart';
import 'package:share_space/presentation/screen/%20section/state/section_state.dart';
import 'package:share_space/presentation/screen/%20section/state/section_type_model.dart';

import '../../../di/injection.dart';
import '../../../domain/usecase/workspace/get_best.dart';
import '../../../domain/usecase/workspace/get_best_price.dart';
import '../../../domain/usecase/workspace/get_featured.dart';
import '../../../domain/usecase/workspace/get_popular.dart';
import '../../../domain/usecase/workspace/get_top_rated.dart';
import '../../design_system/widget/workspace_card.dart';
import '../../routes/routes.dart';

class SectionScreen extends StatelessWidget {
  final SectionType? type;

  const SectionScreen({super.key, this.type});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SectionCubit(
        getIt<GetBestUseCase>(),
        getIt<GetBestPriceUseCase>(),
        getIt<GetFeaturedUseCase>(),
        getIt<GetPopularUseCase>(),
        getIt<GetTopRatedUseCase>(),
      )..loadWorkspaces(type ?? SectionType.best),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            type?.title ?? SectionType.best.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: BlocBuilder<SectionCubit, SectionState>(
          builder: (context, state) {
            if (state is SectionLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is SectionError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (state is SectionLoaded) {
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.workspaces.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final workspace = state.workspaces[index];
                  return WorkspaceCard(
                    imageUrl: workspace.imageUrls.isNotEmpty
                        ? workspace.imageUrls.first
                        : 'https://picsum.photos/200/120',
                    rating: workspace.rate,
                    title: workspace.name,
                    price: 'EGP ${workspace.pricePerHour}/h',
                    location: workspace.locationName,
                    amenities: workspace.services.map((s) => s.name).toList(),
                    onClick: () {
                      Navigator.pushNamed(
                        context,
                        Routes.roomDetailsScreen,
                        arguments: workspace.id,
                      );
                    },
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
