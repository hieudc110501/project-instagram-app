
import 'dart:typed_data';
import 'package:flutter/material.dart' as material show Image;
import 'package:instagram_clone_course/state/image_upload/extensions/get_image_aspect_ratio.dart';

extension GetImageDataAspectRatio on Uint8List {
  Future<double> getAspectRatio() {
    final image = material.Image.memory(this);
    return image.getAspectRatio();
  }
}