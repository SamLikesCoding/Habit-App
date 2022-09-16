// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';

///
///    Library for App Widgets
///

// Text Widgets
class AppTitle extends StatelessWidget {
  final String value;
  const AppTitle({required this.value, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: const TextStyle(
        color: CupertinoColors.white,
        fontFamily: "SF-Pro-Display",
        fontSize: 50,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class AppSubTitle extends StatelessWidget {
  final String value;
  const AppSubTitle({required this.value, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: const TextStyle(
        color: CupertinoColors.white,
        fontFamily: "SF-Pro-Display",
        fontSize: 40,
        fontWeight: FontWeight.w100,
      ),
    );
  }
}

class AppText extends StatelessWidget {
  final String value;
  final double size;
  final Color color;
  const AppText({
    required this.value,
    this.size = 30.0,
    this.color = CupertinoColors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        color: color,
        fontFamily: "SF-Pro-Display",
        fontSize: size,
      ),
    );
  }
}

class AppBoldText extends StatelessWidget {
  final String value;
  final double size;
  final Color color;
  const AppBoldText({
    required this.value,
    this.size = 30.0,
    this.color = CupertinoColors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        color: color,
        fontFamily: "SF-Pro-Display",
        fontSize: size,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

// Spacers
class Spacers extends StatelessWidget {
  final double height, width;
  const Spacers({
    this.height = 5,
    this.width = 5,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width,
        vertical: height,
      ),
    );
  }
}

// Input Gadgets
class TextInputGadget extends StatefulWidget {
  final controller = TextEditingController();
  String label;
  bool isNumber;
  double labelSize;
  TextInputGadget({
    this.label = "Label here",
    this.labelSize = 16,
    this.isNumber = false,
    Key? key,
  }) : super(key: key);
  String get value => controller.text;
  void clearUp() => controller.clear();
  @override
  State<TextInputGadget> createState() => _TextInputGadgetState();
}

class _TextInputGadgetState extends State<TextInputGadget> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField.borderless(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: CupertinoColors.white,
            width: 1,
          ),
        ),
      ),
      keyboardType: widget.isNumber
          ? const TextInputType.numberWithOptions()
          : TextInputType.text,
      padding: const EdgeInsets.all(0.25),
      placeholder: widget.label,
      placeholderStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: widget.labelSize,
        color: CupertinoColors.white,
      ),
      style: TextStyle(
        fontSize: widget.labelSize,
        color: CupertinoColors.white,
      ),
      controller: widget.controller,
    );
  }
}

// Clickables
class AppButton extends StatefulWidget {
  Widget child;
  Function action;
  AppButton({required this.child, required this.action, Key? key})
      : super(key: key);
  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton.filled(
      child: widget.child,
      onPressed: () => widget.action(),
    );
  }
}

class AppCard extends StatefulWidget {
  Widget icon;
  String label;
  Function action;
  double size;
  AppCard({
    this.icon = const Icon(
      CupertinoIcons.arrow_right_square,
      size: 45,
      color: CupertinoColors.white,
    ),
    this.label = "Default",
    this.size = 100,
    required this.action,
    Key? key,
  }) : super(key: key);

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  bool enableColor = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: GestureDetector(
          onTap: () => widget.action(),
          child: Container(
            decoration: const BoxDecoration(
              color: CupertinoColors.systemBlue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.icon,
                const Spacers(
                  height: 5.5,
                ),
                AppText(
                  value: widget.label,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Glass
class GlassContainer extends StatelessWidget {
  double width, height;
  double start, end;
  Widget child;
  GlassContainer({
    required this.child,
    this.width = 100,
    this.height = 100,
    this.start = 0.2,
    this.end = 0.7,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CupertinoColors.white.withOpacity(start),
            CupertinoColors.white.withOpacity(end),
          ],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(9),
        ),
      ),
      child: child,
    );
  }
}
