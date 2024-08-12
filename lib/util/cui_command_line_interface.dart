import 'package:codewave_ui/util/cui_logger.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:process_run/process_run.dart';

class CUICommandLineInterface {
  static final Shell shell = Shell();

  static Future<String?> findGitPath() {
    return which("git");
  }

  static Future<String?> findNpmPath() {
    return which("npm");
  }

  static Future<String?> findNodePath() {
    return which("node");
  }

  static Future<String?> findNpmVersion(String? path) async {
    try {
      String command = path ?? "npm";
      var result = await shell.run('"$command" -v');
      return result.first.outText;
    } catch (err) {
      SmartDialog.showNotify(
          msg: "Failed to get npm version!", notifyType: NotifyType.error);
      CUILogger.warn("Failed to get npm version!");
    }
    return null;
  }

  static Future<String?> findNodeVersion(String? path) async {
    try {
      String command = path ?? "node";
      var result = await shell.run('"$command" -v');
      return result.first.outText.substring(1);
    } catch (err) {
      SmartDialog.showNotify(
          msg: "Failed to get NodeJS version!", notifyType: NotifyType.error);
      CUILogger.warn("Failed to get NodeJS version!");
    }
    return null;
  }

  static Future<void> initializeProjectWithGit(
      String path, String? gitUrl) async {
    try {
      await shell.run('git -C "$path" init');
      if (gitUrl != null) {
        await shell.run('git -C "$path" remote add "origin" $gitUrl');
      }
    } catch (err) {
      SmartDialog.showNotify(
          msg: "Failed to initialize project with git!",
          notifyType: NotifyType.error);
      CUILogger.warn("Failed to initialize project with git!");
    }
  }
}
