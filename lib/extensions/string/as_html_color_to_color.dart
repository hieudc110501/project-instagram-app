
import 'package:flutter/cupertino.dart';
import 'package:instagram_clone_course/extensions/string/remove_all.dart';

//convert color
extension AsHtmlColorToColor on String {
  Color htmlColorToColor() => Color(
        int.parse(
          removeAll(['0x', '#']).padLeft(8, 'ff'),
          radix: 16,
        ),
      );
}
