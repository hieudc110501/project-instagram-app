
import 'package:flutter/foundation.dart';
import 'package:instagram_clone_course/views/components/rich_text/base_text.dart';

@immutable
class LinkText extends BaseText{
  final VoidCallback onTapped;
  const LinkText({
    required super.text,
    required this.onTapped,
    super.style,
  });
}