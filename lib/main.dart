import 'package:finalproject/cubit/convert_cubit.dart';
import 'package:finalproject/pages/login_screen.dart';
import 'package:finalproject/pages/startscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => ConvertCubit(),
    ),
  ], child: const Tox_app()));
}

// ignore: camel_case_types
class Tox_app extends StatefulWidget {
  const Tox_app({super.key});

  @override
  State<Tox_app> createState() => _appState();
}

// ignore: camel_case_types
class _appState extends State<Tox_app> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: const startscreen(),
    );
  }
}
