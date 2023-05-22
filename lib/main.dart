import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobkar_pro/controller/auth_controller.dart';
import 'package:jobkar_pro/controller/data_controller.dart';
import 'package:jobkar_pro/controller/post_controller.dart';
import 'package:jobkar_pro/controller/update_controller.dart';
import 'package:jobkar_pro/view/page/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.black, systemNavigationBarColor: Colors.white));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => PostController()),
        ChangeNotifierProvider(create: (_) => UpdateController()),
        ChangeNotifierProvider(create: (_) => DataController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'hiredge',
        home: SafeArea(
          child: SplashScreen(),
        ),
      ),
    );
  }
}
