import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AnimalImagePickerWidget extends StatelessWidget {
  final Function(File) onImageSelected;

  const AnimalImagePickerWidget({Key? key, required this.onImageSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          _buildListTile(
            title: 'Camera'.tr,
            icon: Icons.camera_alt,
            onTap: () async {
              Navigator.pop(context);
              final pickedImage =
                  await ImagePicker().pickImage(source: ImageSource.camera);
              if (pickedImage != null) {
                onImageSelected(File(pickedImage.path));
              }
            },
          ),
          _buildDivider(),
          _buildListTile(
            title: 'Gallery'.tr,
            icon: Icons.photo,
            onTap: () async {
              Navigator.pop(context);
              final pickedImage =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickedImage != null) {
                onImageSelected(File(pickedImage.path));
              }
            },
          ),
          _buildDivider(),
        ],
      ),
    );
  }

  Widget _buildListTile(
      {required String title,
      required IconData icon,
      required Function onTap}) {
    return ListTile(
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: Colors.black, // Set your desired color
      ),
      title: Text(title),
      onTap: () => onTap(),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      width: double.infinity,
      color: Colors.grey,
    );
  }
}
