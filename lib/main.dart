import 'dart:collection';

import 'package:finalproject/models/Mutagenicity.dart';
import 'package:finalproject/models/Similarity_map.dart';
import 'package:finalproject/models/ToxicityofMolecules.dart';
import 'package:finalproject/models/liver_toxicity.dart';
import 'package:finalproject/pages/EditProfilePage.dart';
import 'package:finalproject/pages/change_pass.dart';
import 'package:finalproject/pages/changedSuccessfully.dart';
import 'package:finalproject/pages/info.dart';

import 'package:finalproject/pages/login_screen.dart';
import 'package:finalproject/pages/signup.dart';
import 'package:finalproject/pages/startscreen.dart';
import 'package:finalproject/result/liver_result.dart';
import 'package:finalproject/result/mutagenicity_result.dart';
import 'package:finalproject/result/similarty_result.dart';
import 'package:finalproject/screens/bottomnavbar.dart';

import 'package:finalproject/screens/home.dart';
import 'package:finalproject/screens/profile.dart';
import 'package:finalproject/screens/settings.dart';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const app());
}

class app extends StatefulWidget {
  const app({super.key});

  @override
  State<app> createState() => _appState();
}

class _appState extends State<app> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(fontFamily: 'Poppins'),
        debugShowCheckedModeBanner: false,
        home: mutresult());
  }
}
