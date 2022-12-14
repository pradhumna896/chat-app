

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);

 final void Function(XFile pickedImage) imagePickFn;
  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  XFile? _pickImage;
  void _pickedImage()async{
   final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
   setState(() {
     _pickImage= XFile(pickedImageFile!.path);
   });
   widget.imagePickFn(pickedImageFile!);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
           CircleAvatar(
                    radius: 40,
                    backgroundImage: _pickImage != null ? FileImage(File(_pickImage!.path)):null,
                  ),
                  TextButton.icon(
                    
                      onPressed: () {
                        _pickedImage();
                      },
                      icon: Icon(Icons.image),
                      label: Text('Add Image')),
      ],
    );
    
  }
}