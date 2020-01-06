import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  final int maxLines;

  final TextStyle style;

  final bool expand;

  ExpandableText(this.text, this.maxLines, this.style, this.expand);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ExpandableTextState();
  }
}

class _ExpandableTextState extends State<ExpandableText> {

  String text;

  int maxLines;

  TextStyle style;

  bool expand;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    text = widget.text;
    maxLines = widget.maxLines;
    style = widget.style;
    expand = widget.expand;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LayoutBuilder(
      builder: (ctx, size) {
        final span = TextSpan(text: text ?? "", style: widget.style);
        final tp = TextPainter(
            text: span,
            maxLines: maxLines,
            textDirection: TextDirection.ltr);
        tp.layout(maxWidth: size.maxWidth);
        return tp.didExceedMaxLines
            ? Column(
                children: <Widget>[
                 expand
                      ? Text(text ?? "", style: style)
                      : Column(
                          children: <Widget>[
                            Text(text ?? "", style: style,maxLines: maxLines,overflow: TextOverflow.ellipsis,)
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                  IconButton(icon: Icon(expand?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down), onPressed: (){
                    setState(() {
                      expand = !expand;
                    });
                  })
                ],
              )
            : Text(text ?? "", style: style);
      },
    );
  }
}
