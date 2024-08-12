import 'dart:async';
import 'dart:ui';

class CUIDebouncer {
  final int milliseconds;
  Timer? _timer;

  CUIDebouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
