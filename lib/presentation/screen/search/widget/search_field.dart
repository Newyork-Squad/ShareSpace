import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';
import 'package:share_space/presentation/screen/search/widget/filter_button.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchAnchor(
                viewConstraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.3,
                ),
                viewBackgroundColor: theme.colors.surfaceLow,
                dividerColor: Colors.transparent,
                isFullScreen: false,
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    hintText: "Search by room, location...",
                    hintStyle: WidgetStatePropertyAll(
                      theme.typography.textTheme.labelMedium?.copyWith(
                        color: theme.colors.body,
                      ),
                    ),
                    elevation: WidgetStatePropertyAll(0.0),
                    backgroundColor: WidgetStatePropertyAll(theme.colors.surfaceLow),
                    controller: controller,
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide(color: theme.colors.stroke, width: 0.5),
                      ),
                    ),
                    padding: const WidgetStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (_) {
                      controller.openView();
                    },
                    leading: SvgPicture.asset(
                      'assets/icons/search.svg',
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(theme.colors.body, BlendMode.srcIn),
                    ),
                  );
                },
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                      return List<ListTile>.generate(5, (int index) {
                        final String item = 'item $index';
                        return ListTile(
                          title: Text(item),
                          onTap: () {
                            setState(() {
                              controller.closeView(item);
                            });
                          },
                        );
                      });
                    },
              ),
          ),
        ),
        FilterButton()
      ],
    );
  }
}
