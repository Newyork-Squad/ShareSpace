
import 'package:flutter/material.dart';
import 'package:share_space/presentation/screen/room_details/widgets/room_image_slider.dart';

class RoomDetailsBody extends StatelessWidget{
   RoomDetailsBody({super.key});
  final List<String> roomImages = const [
    'assets/images/room_image.png',
    'assets/images/room_image.png',
    'assets/images/room_image.png',
    'assets/images/room_image.png',


  ];

  final ValueNotifier<int> _currentIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    return CustomScrollView(
     slivers: [
       SliverToBoxAdapter(child: RoomImageSlider(images: roomImages,currentIndex: _currentIndex,controller: pageController,rate: '5',),),

     ]
   );

  }


}