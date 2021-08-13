import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:bloodsquad/widgets/imagewidget.dart';
import 'package:google_fonts/google_fonts.dart';

class RegForm extends StatefulWidget {
  RegForm(this.submitFn, this._isLoadin);
  final bool _isLoadin;
  final void Function(
      String name,
      String email,
      String password,
      // String confirmPassword,
      String contactNo,
      String district,
      String height,
      String weight,
      String bloodgroop,
      File pickImage,
      BuildContext ctx) submitFn;

  @override
  _RegFormState createState() => _RegFormState();
}

class _RegFormState extends State<RegForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _name;
  String? _email;
  // String? _city;
  String? _password;
  String? _contactNo;
  String? _district;
  // String? _confirmPassword;
  String? _height;
  String? _weight;
  String? _bloodgroop;
  File? _pickedImage;

  void isValid() {
    if (_pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pleas pick an image'),
        ),
      );
    }
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      _formKey.currentState!.save();
      widget.submitFn(
          _name!.trim(),
          _email!.trim(),
          _password!.trim(),
          // _city!.trim(),
          _district!.trim(),
          _contactNo!.trim(),
          _height!.trim(),
          _weight!.trim(),
          _bloodgroop!.trim(),
          _pickedImage!,
          context);
    }
  }

  void _pickImages() async {
    final pickedImageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 150, maxWidth: 150);

    setState(() {
      _pickedImage = pickedImageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Scaffold(
      body: Container(
        decoration: backgroundImage(),
        child: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Text(
                      'Registration \nform',
                      style: GoogleFonts.montserrat(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.grey,
                        backgroundImage: _pickedImage != null
                            ? FileImage(_pickedImage!)
                            : null,
                      ),
                      Positioned(
                        child: TextButton(
                          child: buildEditIcon(color),
                          onPressed: _pickImages,
                        ),
                        bottom: -5,
                        right: -12,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                    padding: EdgeInsets.all(8),
                                    child: _bulildNameFeild()),
                                Padding(
                                    padding: EdgeInsets.all(8),
                                    child: _bulildEmailFeild()),
                                Padding(
                                    padding: EdgeInsets.all(8),
                                    child: _bulildIdFeild()),
                                // Padding(
                                //     padding: EdgeInsets.all(8),
                                //     child: _bulildConfirmIdFeild()),
                                Padding(
                                    padding: EdgeInsets.all(8),
                                    child: _bulildContactNoFeild()),
                                Padding(
                                    padding: EdgeInsets.all(8),
                                    child: _bulildDistrictFeild()),
                                Padding(
                                    padding: EdgeInsets.all(8),
                                    child: _bulildheightFeild()),
                                Padding(
                                    padding: EdgeInsets.all(8),
                                    child: _bulildWeightFeild()),
                                Padding(
                                    padding: EdgeInsets.all(8),
                                    child: _bulildBGroupFeild()),
                                if (widget._isLoadin)
                                  CircularProgressIndicator(),
                                if (!widget._isLoadin)
                                  ElevatedButton(
                                      child: Text('Submit'),
                                      onPressed: () {
                                        CircularProgressIndicator();
                                        return isValid();
                                      })
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );
  Widget buildCircle({
    Widget? child,
    double? all,
    Color? color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(5),
          color: color,
          child: child,
        ),
      );

  Widget _bulildNameFeild() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Name',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      validator: (text) {
        if (text!.isEmpty) {
          return 'Plese enter your Name';
        }
        return null;
      },
      onSaved: (text) {
        _name = text!;
      },
    );
  }

  Widget _bulildEmailFeild() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      validator: (text) {
        if (text!.isEmpty || !text.contains('@')) {
          return 'Plese enter valid email';
        }
        return null;
      },
      onSaved: (text) {
        _email = text!;
      },
    );
  }

  Widget _bulildIdFeild() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      validator: (text) {
        if (text!.isEmpty || text.length < 7) {
          return 'Please enter strong password';
        }
        return null;
      },
      onSaved: (text) {
        _password = text!;
      },
    );
  }

  // Widget _bulildConfirmIdFeild() {
  //   return TextFormField(
  //     obscureText: true,
  //     decoration: InputDecoration(
  //       labelText: 'Confirm Password',
  //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
  //     ),
  //     validator: (text) {
  //       if (text!.isEmpty || text != _password) {
  //         return 'Password doesnt match';
  //       }
  //       return null;
  //     },
  //     onSaved: (text) {
  //       _confirmPassword = text!;
  //     },
  //   );
  // }

  Widget _bulildContactNoFeild() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Contact  No ex- 770000000',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      validator: (text) {
        if (text!.isEmpty) {
          return text = 'null';
        }
        return null;
      },
      onSaved: (text) {
        _contactNo = text!;
      },
    );
  }

  // Widget _bulildCityFeild() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //       labelText: 'City',
  //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
  //     ),
  //     validator: (text) {
  //       if (text!.isEmpty) {
  //         return 'City cannot be empty';
  //       }
  //       return null;
  //     },
  //     onSaved: (text) {
  //       _city = text!;
  //     },
  //   );
  // }

  Widget _bulildDistrictFeild() {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Disteric',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
        validator: (text) {
          if (text!.isEmpty) {
            return 'Distric cannot be empty';
          }
          return null;
        },
        onSaved: (text) {
          _district = text!;
        },
      ),
    );
  }

  Widget _bulildheightFeild() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'height (cm)',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      validator: (text) {
        if (text!.isEmpty) {
          return text = '0';
        }
        return null;
      },
      onSaved: (text) {
        _height = text!;
      },
    );
  }

  Widget _bulildWeightFeild() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Weight (Kg)',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      validator: (text) {
        if (text!.isEmpty) {
          return text = 'null';
        }
        return null;
      },
      onSaved: (text) {
        _weight = text!;
      },
    );
  }

  Widget _bulildBGroupFeild() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Blood Group',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      validator: (text) {
        if (text!.isEmpty) {
          return text = 'ng';
        }
        return null;
      },
      onSaved: (text) {
        _bloodgroop = text!;
      },
    );
  }
}
