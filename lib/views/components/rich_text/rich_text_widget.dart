import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:instagram_clone_course/views/components/rich_text/base_text.dart';
import 'package:instagram_clone_course/views/components/rich_text/link_text.dart';

class RichTextWidget extends StatelessWidget {
  final Iterable<BaseText> texts;
  final TextStyle? styleForAll;

  const RichTextWidget({
    super.key,
    required this.texts,
    this.styleForAll,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: texts.map(
          (basetext) {
            if (basetext is LinkText) {
              return TextSpan(
                text: basetext.text,
                style: styleForAll?.merge(basetext.style),
                recognizer: TapGestureRecognizer()..onTap = basetext.onTapped,
              );
            } else {
              return TextSpan(
                text: basetext.text,
                style: styleForAll?.merge(basetext.style),
              );
            }
          },
        ).toList(),
      ),
    );
  }
}
