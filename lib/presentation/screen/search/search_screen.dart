import 'package:flutter/material.dart';
import 'package:share_space/presentation/screen/search/widget/search_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SearchField()),
        SliverToBoxAdapter(child: Container(height: 500, color: Colors.red)),
        SliverToBoxAdapter(child: Container(height: 500, color: Colors.black)),
        SliverToBoxAdapter(child: Container(height: 500, color: Colors.blue)),
      ],
    );
  }
}
