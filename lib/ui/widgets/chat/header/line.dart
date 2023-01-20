import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/theme/theme.dart';

class Line extends StatefulWidget {
  const Line({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LineState();
}

class _LineState extends State<Line> with SingleTickerProviderStateMixin {
  double _progress = 0.0;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    var controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);

    animation = Tween(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {
          _progress = animation.value;
        });
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: LinePainter(
            _progress,
            Paint()
              ..color = AppColors.red
              ..strokeWidth = 2.0));
  }
}

class LinePainter extends CustomPainter {
  final Paint _paint;
  final double _progress;

  LinePainter(this._progress, this._paint);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
        const Offset(0.0, 0.0),
        Offset(size.width - size.width * _progress,
            size.height - size.height * _progress),
        _paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return oldDelegate._progress != _progress;
  }
}
