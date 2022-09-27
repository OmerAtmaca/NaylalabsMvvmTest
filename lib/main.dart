import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tryproject/core/shared_manager.dart';
import 'package:tryproject/model/stories_model.dart';
import 'package:tryproject/mvvm/login.dart';
import 'package:tryproject/view/main_menu.dart';
import 'package:tryproject/view/story_side_bar.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedManager.instance.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     theme: ThemeData(bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent)),
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: "/login",
        routes: {
          "/": (context) => const MainManuView(),
          "/login": (context) => const Login(),
        });
  }
}
