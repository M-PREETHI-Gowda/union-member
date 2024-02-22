import 'package:flutter/material.dart';


void showImagePicker(BuildContext context, VoidCallback imgFromGallery, VoidCallback imgFromCamera) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: [
                ListTile(
                    leading:  const Icon(Icons.photo_library),
                    title:  const Text('Gallery'),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading:  const Icon(Icons.photo_camera),
                  title:  const Text('Camera'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      });
}