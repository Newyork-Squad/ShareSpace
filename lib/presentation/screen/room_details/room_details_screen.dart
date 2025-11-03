
import 'package:flutter/material.dart';
import 'package:share_space/presentation/screen/room_details/widgets/room_booking_bar.dart';
import 'package:share_space/presentation/screen/room_details/widgets/room_details_body.dart';

class RoomDetailsScreen extends StatelessWidget{
  final String price='12,000 IQD/h';
  const RoomDetailsScreen({super.key});


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: RoomDetailsBody(),
     bottomNavigationBar:RoomBookingBar(price: price,),
   );
  }
  
}