import 'package:flutter/material.dart';

import '../../../design_system/theme/app_theme.dart';

class RoomOwnerSection extends StatelessWidget {
  final String name;
  final String role;
  final String imagePath;

  const RoomOwnerSection({
    super.key,
    required this.name,
    required this.role,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return
      ListTile(
      leading: CircleAvatar(
        backgroundImage: Image.asset(imagePath).image,
      ),
      title: Text(
        name,
        style: theme.typography.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w500,
          color: theme.colors.title,
        ),
      ),
      subtitle: Text(role,
      style: theme.typography.textTheme.labelMedium?.copyWith(
        fontWeight: FontWeight.w500,
        color: theme.colors.body,
      ),),
      trailing: IconButton(
        icon: Image.asset(
          'assets/images/chat.png',
          width: 40,
          height: 40,
          fit: BoxFit.fill,
        ),
        onPressed: (){
          print('lets chat');
        },
      ),
    );  }
}
