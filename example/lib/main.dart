import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

void main() async {
  await GetStorage.init();
  runApp(App());
}

class Controller extends ChangeNotifier {
  final box = GetStorage();
  bool get isDark => box.read('darkmode') ?? false;
  ThemeData get theme => isDark ? ThemeData.dark() : ThemeData.light();
  void changeTheme(bool val) {
    box.write('darkmode', val);
    notifyListeners();
  }
}

class App extends StatelessWidget {
  final controller = Controller();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => controller,
        builder: (context, child) {
          return MaterialApp(
            theme: controller.theme,
            home: Scaffold(
              appBar: AppBar(title: Text("Get Storage")),
              body: Center(
                child: SwitchListTile(
                  value: controller.isDark,
                  title: Text("Touch to change ThemeMode"),
                  onChanged: controller.changeTheme,
                ),
              ),
            ),
          );
        });
  }
}
