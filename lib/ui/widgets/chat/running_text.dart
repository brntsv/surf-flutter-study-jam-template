import 'dart:async';

import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/utils.dart';

class RunningText extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final Axis scrollAxis;
  final double ratioOfBlankToScreen;

  const RunningText({
    Key? key,
    required this.text,
    required this.textStyle,
    this.scrollAxis = Axis.horizontal,
    this.ratioOfBlankToScreen = 0.25,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RunningTextState();
  }
}

class RunningTextState extends State<RunningText>
    with SingleTickerProviderStateMixin {
  late ScrollController scrollController;
  double screenWidth = 0;
  double screenHeight = 0;
  double position = 0.0;
  Timer? timer;
  final double _moveDistance = 4.0;
  final int _timerRest = 100;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      startTimer();
    });
  }

  void startTimer() {
    final currentContext = _key.currentContext;
    if (currentContext != null) {
      final renderObject = currentContext.findRenderObject();
      if (renderObject != null) {
        double widgetWidth = renderObject.paintBounds.size.width;
        double widgetHeight = renderObject.paintBounds.size.height;

        timer = Timer.periodic(Duration(milliseconds: _timerRest), (timer) {
          double maxScrollExtent = scrollController.position.maxScrollExtent;
          double pixels = scrollController.position.pixels;
          if (pixels + _moveDistance >= maxScrollExtent) {
            if (widget.scrollAxis == Axis.horizontal) {
              position = (maxScrollExtent -
                          screenWidth * widget.ratioOfBlankToScreen +
                          widgetWidth) /
                      2 -
                  widgetWidth +
                  pixels -
                  maxScrollExtent;
            } else {
              position = (maxScrollExtent -
                          screenHeight * widget.ratioOfBlankToScreen +
                          widgetHeight) /
                      2 -
                  widgetHeight +
                  pixels -
                  maxScrollExtent;
            }
            scrollController.jumpTo(position);
          }
          position += _moveDistance;
          scrollController.animateTo(position,
              duration: Duration(milliseconds: _timerRest),
              curve: Curves.linear);
        });
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = context.width;
    screenHeight = context.height;
  }

  Widget getBothEndsChild() {
    if (widget.scrollAxis == Axis.vertical) {
      String newString = widget.text.split('').join('\n');
      return Center(
        child: Text(
          newString,
          style: widget.textStyle,
          textAlign: TextAlign.center,
        ),
      );
    }
    return Center(
        child: Text(
      widget.text,
      style: widget.textStyle,
    ));
  }

  Widget getCenterChild() {
    if (widget.scrollAxis == Axis.horizontal) {
      return Container(width: screenWidth * widget.ratioOfBlankToScreen);
    } else {
      return Container(height: screenHeight * widget.ratioOfBlankToScreen);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: _key,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: widget.scrollAxis,
      controller: scrollController,
      children: <Widget>[
        getBothEndsChild(),
        getCenterChild(),
        getBothEndsChild(),
      ],
    );
  }
}
