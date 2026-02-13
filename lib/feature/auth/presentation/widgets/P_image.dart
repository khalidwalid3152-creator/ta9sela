// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:ta9sela/core/constants/app_images.dart';

// class ReusableImagePicker extends StatefulWidget {
//   final File? initialImage;
//   final Function(File) onImageSelected;
//   final double width;
//   final double height;
//   final String placeholderText;
//   final BorderRadius borderRadius;
//   final Color borderColor;

//   const ReusableImagePicker({
//     super.key,
//     this.initialImage,
//     required this.onImageSelected,
//     this.width = 150,
//     this.height = 150,
//     this.placeholderText = "اضغط لاختيار صورة",
//     this.borderRadius = const BorderRadius.all(Radius.circular(10)),
//     this.borderColor = Colors.grey,
//   });

//   @override
//   State<ReusableImagePicker> createState() => _ReusableImagePickerState();
// }

// class _ReusableImagePickerState extends State<ReusableImagePicker> {
//   File? image;

//   @override
//   void initState() {
//     super.initState();
//     image = widget.initialImage;
//   }

//   Future<void> pickImage(ImageSource source) async {
//     final picked = await ImagePicker().pickImage(source: source);
//     if (picked != null) {
//       final file = File(picked.path);
//       setState(() => image = file);
//       widget.onImageSelected(file);
//     }
//   }

//   void showPickerBottomSheet() {
//     showModalBottomSheet(
//       context: context,
//       builder: (_) => Column(

//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             title: const Text("المعرض",textAlign: TextAlign.center,),
//             onTap: () {
//               Navigator.pop(context);
//               pickImage(ImageSource.gallery);
//             },
//           ),
//           ListTile(
//             title: const Text("الكاميرا",textAlign: TextAlign.center,),
//             onTap: () {
//               Navigator.pop(context);
//               pickImage(ImageSource.camera);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(

//       onTap: showPickerBottomSheet,
//       child: Container(
//         width: widget.width,
//         height: widget.height,
//         decoration: BoxDecoration(
//           borderRadius: widget.borderRadius,
//           border: Border.all(color: widget.borderColor),
//         ),
//         alignment: Alignment.center,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SvgPicture.asset(AppImages.camera),
//             image == null
//                 ? Text(widget.placeholderText)
//                 : ClipRRect(
//                     borderRadius: widget.borderRadius,
//                     child: Image.file(image!, fit: BoxFit.cover),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:ta9sela/core/constants/app_images.dart';

class ReusableImagePicker extends StatefulWidget {
  final String? initialImageUrl;
  final Function(String) onImageUploaded; // هيرجع URL
  final double width;
  final double height;
  final String placeholderText;
  final BorderRadius borderRadius;
  final Color borderColor;

  const ReusableImagePicker({
    super.key,
    this.initialImageUrl,
    required this.onImageUploaded,
    this.width = 150,
    this.height = 150,
    this.placeholderText = "اضغط لاختيار صورة",
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.borderColor = Colors.grey, required Function(dynamic file) onImageSelected,
  });

  @override
  State<ReusableImagePicker> createState() => _ReusableImagePickerState();
}

class _ReusableImagePickerState extends State<ReusableImagePicker> {
  File? _imageFile;
  String? _imageUrl;
  bool _isUploading = false;

  final CloudinaryPublic _cloudinary = CloudinaryPublic(
    'dfplculyh',
    'kimage',
    cache: false,
  );

  @override
  void initState() {
    super.initState();
    _imageUrl = widget.initialImageUrl;
  }

  Future<void> _pickAndUploadImage(ImageSource source) async {
    final picked = await ImagePicker().pickImage(
      source: source,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 80,
    );
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
        _isUploading = true;
      });

      try {
        CloudinaryResponse response = await _cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            _imageFile!.path,
            resourceType: CloudinaryResourceType.Image,
          ),
        );

        setState(() {
          _imageUrl = response.secureUrl;
          _isUploading = false;
        });

        widget.onImageUploaded(_imageUrl!); // ترجّع URL للفاييرستور
      } catch (e) {
        setState(() => _isUploading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('فشل رفع الصورة: $e')));
      }
    }
  }

  void _showPickerBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text("المعرض", textAlign: TextAlign.center),
            onTap: () {
              Navigator.pop(context);
              _pickAndUploadImage(ImageSource.gallery);
            },
          ),
          ListTile(
            title: const Text("الكاميرا", textAlign: TextAlign.center),
            onTap: () {
              Navigator.pop(context);
              _pickAndUploadImage(ImageSource.camera);
            },
          ),
          ListTile(
            title: const Text("إلغاء", textAlign: TextAlign.center),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showPickerBottomSheet,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          border: Border.all(color: widget.borderColor),
        ),
        alignment: Alignment.center,
        child: _isUploading
            ? const CircularProgressIndicator()
            : _imageUrl != null
            ? ClipRRect(
                borderRadius: widget.borderRadius,
                child: Image.network(
                  _imageUrl!,
                  width: widget.width,
                  height: widget.height,
                  fit: BoxFit.cover,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppImages.camera, width: 40, height: 40),
                  const SizedBox(height: 8),
                  Text(widget.placeholderText, textAlign: TextAlign.center),
                ],
              ),
      ),
    );
  }
}
