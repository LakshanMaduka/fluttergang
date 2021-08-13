import 'package:flutter/cupertino.dart';

import '';

backgroundImage() {
  var back = BoxDecoration(
    image: DecorationImage(
      image: ExactAssetImage('assets/images/login.png'),
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
    ),
  );
  return back;
}

ImageWidget(String path) {
  var img = BoxDecoration(
    image: DecorationImage(
      image: ExactAssetImage(path),
      fit: BoxFit.fill,
      alignment: Alignment.topCenter,
    ),
  );
  return img;
}
