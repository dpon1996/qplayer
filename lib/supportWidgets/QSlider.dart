import 'package:flutter/material.dart';

class QSlider extends StatefulWidget {
  final Widget child;
  final bool hideThumb;

  const QSlider({Key? key, required this.child, this.hideThumb = false})
      : super(key: key);

  @override
  _QSliderState createState() => _QSliderState();
}

class _QSliderState extends State<QSlider> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        thumbShape: widget.hideThumb ? SliderComponentShape.noOverlay : RoundSliderThumbShape(enabledThumbRadius: 6),
        trackShape: CustomTrackShape(),
        trackHeight: 2,
      ),
      child: widget.child,
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
