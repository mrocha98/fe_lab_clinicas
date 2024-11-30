import 'package:flutter/widgets.dart';

extension ScreenSizeX on BuildContext {
  Size get _size => MediaQuery.sizeOf(this);

  double get screenWidth => _size.width;

  double get screenHeight => _size.height;

  double screenWidthPercent(double percent) => _size.width * percent;

  double screenHeightPercent(double percent) => _size.height * percent;
}
