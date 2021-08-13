//@dart=2.9
import 'dart:io';

import 'package:flutter/material.dart';

class UserImagePicker extends StatefulWidget {
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // FlatButton.icon(
        //   textColor: Theme.of(context).primaryColor,
        //   onPressed: _pickImage,
        //   icon: Icon(Icons.image),
        //   label: Text('Add Image'),
        // ),
      ],
    );
  }
}
