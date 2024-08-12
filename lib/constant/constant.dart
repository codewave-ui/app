import 'dart:io';

sealed class CUIConstant {
  static WindowsConstant windowsConstant = WindowsConstant();
  final String npmExecutableFileExtensions;
  final String nodeExecutableFileExtensions;

  CUIConstant(
      {required this.npmExecutableFileExtensions,
      required this.nodeExecutableFileExtensions});

  static CUIConstant getConstantValue() {
    if (Platform.operatingSystem == "windows") {
      return windowsConstant;
    }
    throw UnsupportedError("The operating system is not supported!");
  }
}

class WindowsConstant extends CUIConstant {
  WindowsConstant()
      : super(
            npmExecutableFileExtensions: "cmd",
            nodeExecutableFileExtensions: "exe");
}
