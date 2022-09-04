import 'package:flutter/foundation.dart';

class ValueStorage<T> extends ValueNotifier<T> implements ValueListenable<T> {
  ValueStorage(T value) : super(value);
  List<VoidCallback?>? _updaters = <VoidCallback?>[];

  Map<String, dynamic> changes = <String, dynamic>{};

  void changeValue(String key, dynamic value) {
    changes = {key: value};
    _notifyUpdate();
  }

  void _notifyUpdate() {
    notifyListeners();

    for (var element in _updaters!) {
      element!();
    }
  }

  @override
  VoidCallback addListener(VoidCallback listener) {
    assert(_debugAssertNotDisposed());
    _updaters!.add(listener);
    return () => _updaters!.remove(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    assert(_debugAssertNotDisposed());
    _updaters!.remove(listener);
  }

  bool _debugAssertNotDisposed() {
    assert(() {
      if (_updaters == null) {
        throw FlutterError('''A $runtimeType was used after being disposed.\n
'Once you have called dispose() on a $runtimeType, it can no longer be used.''');
      }
      return true;
    }());
    return true;
  }
}
