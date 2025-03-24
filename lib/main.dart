import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/business%20logic/all%20logic%20here.dart';
import 'package:flutter_e_commerce/ui/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'business logic/registration logic.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => BusinessLogic(),),
    ChangeNotifierProvider(create: (context) => RegistrationLogic(),),

  ],child: const HomePage(),));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _loadDatabase() async {
    try {
      await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyBc7QN_iVe0grfnmqMGIsOBNzDZ08ZeKLM',
              appId: '1:490949449968:android:63607109946c950f148a35',
              messagingSenderId: '490949449968',
              projectId: 'flutter-e-commerce-280f7')

      );
    } catch (e) {
      print("$e Error Occured!!! Not Connect firebase");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const SplashScreen(),
        );
      },
    );
  }
}
