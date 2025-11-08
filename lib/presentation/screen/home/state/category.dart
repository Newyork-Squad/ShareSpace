import '../../../../domain/entity/workspace.dart';
import 'dart:math';

class Category {
  final String name;
  final String description;
  final List<Workspace> workspaces;

  Category({
    required this.name,
    required this.description,
    required List<Workspace>? workspaces,
  }) : workspaces = workspaces ?? [];

  String getImage() {
    const fallbacks =
        ['https://www.erfurt.com/fileadmin/user_upload/tipps-inspirationen/tipps-tricks/raumwirkung/Leerer-Raum-graue-Wand-weisser-streifenunten-weissedecke_620x417px.jpg',
        "https://img-cdn.inc.com/image/upload/f_webp,c_fit,w_1920,q_auto/images/panoramic/getty_517610514_353435.jpg"];
    final fallback = fallbacks[Random().nextInt(fallbacks.length)];
    if (workspaces.isEmpty) return fallback;
    final img = workspaces.first.imageUrls[0];
    return img.isNotEmpty ? img : fallback;
    // return fallback;

  }
}
