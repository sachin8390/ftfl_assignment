import 'package:flutter/cupertino.dart';

class SizeConfig {
  SizeConfig._();

  static late double screenHeight;
  static late double screenWidth;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  static void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      screenWidth = constraints.maxWidth;
      screenHeight = constraints.maxHeight;
      print("portrait height === > $screenHeight");
      print("portrait width === > $screenWidth");
    } else {
      screenHeight = constraints.maxWidth;
      screenWidth = constraints.maxHeight;
      print("landscape height === > $screenHeight");
      print("landscape width === > $screenWidth");
    }
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    print("block height === > $blockSizeVertical");
    print("block width === > $blockSizeHorizontal");
  }

  static double setSp(num size) => size * blockSizeVertical;
  static double setHeight(num size) => size * blockSizeVertical;
  static double setWidth(num size) => size * blockSizeHorizontal;
}

extension SizeExtensionInteger on num {
  double get t => SizeConfig.setSp(this);
  double get h => SizeConfig.setHeight(this);
  double get w => SizeConfig.setWidth(this);
}
