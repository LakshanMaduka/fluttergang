import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

// class Formfeild extends StatelessWidget {
//   String? hinttext;
//   String? errormessag;
//   String? field;
//   Formfeild(
//       {required String hintText,
//       required String errormessage,
//       required String? feild}) {
//     this.hinttext = hintText;
//     this.errormessag = errormessage;
//     this.field = field;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       decoration: InputDecoration(
//         labelText: hinttext,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//       ),
//       validator: (text) {
//         if (text!.isEmpty) {
//           return errormessag;
//         }
//         return null;
//       },
//       onSaved: (text) {
//         field = text!;
//       },
//     );
//   }
// }
Widget FromFeild2(
  String? hinttext,
  String? errormessag,
  String? field,
) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: hinttext,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    ),
    validator: (text) {
      if (text!.isEmpty) {
        return errormessag;
      }
      return null;
    },
    onSaved: (text) {
      field = text!;
    },
  );
}
