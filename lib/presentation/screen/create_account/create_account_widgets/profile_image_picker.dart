import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../../design_system/colors/app_color.dart';

class ProfileImagePicker extends StatefulWidget {
  final Function(String?)? onImageSelected;

  const ProfileImagePicker({
    super.key,
    this.onImageSelected,
  });

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });

      widget.onImageSelected?.call(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasImage = _selectedImage != null;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.light.stroke, width: 0.5),
              color: AppColors.light.surface,
            ),
            child: ClipOval(
              child: hasImage
                  ? Image.file(
                _selectedImage!,
                fit: BoxFit.cover,
                width: 88,
                height: 88,
              )
                  : Center(
                child: SizedBox(
                  child: SvgPicture.asset(
                    'assets/icons/add_image_icon.svg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (hasImage)
          Positioned(
            bottom: -28,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(4),
                child: SvgPicture.asset(
                  'assets/icons/edit_image_icon.svg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
      ],
    );
  }
}