import 'package:flutter/material.dart';

import 'package:surf_practice_chat_flutter/theme.dart';
import 'package:surf_practice_chat_flutter/ui/widgets/chat/header/line.dart';

class HeaderBar extends StatefulWidget {
  final String text;
  const HeaderBar({Key? key, required this.text}) : super(key: key);

  @override
  State<HeaderBar> createState() => _HeaderBarState();
}

class _HeaderBarState extends State<HeaderBar> {
  // late Timer _timer;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      setState(() {
        isTextShow = !isTextShow;
      });
    });
  }

  bool isTextShow = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(child: Line()),
          GestureDetector(
            onTap: (() => setState(() {})),
            child: AnimatedContainer(
                height: isTextShow ? 40 : 0,
                duration: const Duration(milliseconds: 1500),
                margin: const EdgeInsets.fromLTRB(5, 3, 5, 0),
                child: Text(
                  widget.text,
                  style: TxtStyle.blender25Blue,
                )),
          ),
          const Expanded(child: Line()),
        ],
      ),
    );
  }
}
