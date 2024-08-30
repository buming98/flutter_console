library flutter_console_widget;

import 'package:flutter/material.dart';
import 'package:flutter_console_widget/flutter_console_controller.dart';
import 'package:flutter_console_widget/selectable_colored_text.dart';

export 'package:flutter_console_widget/flutter_console_controller.dart';

class FlutterConsole extends StatelessWidget {
  const FlutterConsole({
    this.consoleBackground = Colors.black,
    this.consoleTextColor = Colors.white,
    this.consoleSelectedTextBackgroundColor = Colors.white,
    this.consoleSelectedTextColor = Colors.black,
    required this.controller,
    required this.height,
    this.inputBackground = const Color(0xff333333),
    this.inputTextColor = Colors.white,
    Key? key,
    this.scrollColor = Colors.grey,
    required this.width,
  }) : super(key: key);

  final Color consoleBackground;
  final Color consoleTextColor;
  final Color consoleSelectedTextBackgroundColor;
  final Color consoleSelectedTextColor;
  final FlutterConsoleController controller;
  final double height;
  final Color inputBackground;
  final Color inputTextColor;
  final Color scrollColor;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<FlutterConsoleData>(
        valueListenable: controller,
        builder: (context, consoleData, _) {
          return !consoleData.show
              ? const SizedBox.shrink()
              : Container(
                  color: consoleBackground,
                  width: width,
                  height: height,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: width,
                          child: Theme(
                            data: ThemeData.light().copyWith(
                                scrollbarTheme:
                                    const ScrollbarThemeData().copyWith(
                              thumbColor:
                                  MaterialStateProperty.all(scrollColor),
                            )),
                            child: Scrollbar(
                              controller: controller.scrollController,
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                controller: controller.scrollController,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SelectableColoredText(
                                    consoleData.consoleContent,
                                    style: TextStyle(
                                      color: consoleTextColor,
                                    ),
                                    selectedTextColor: consoleSelectedTextColor,
                                    selectedTextBackgroundColor:
                                        consoleSelectedTextBackgroundColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        });
  }
}
