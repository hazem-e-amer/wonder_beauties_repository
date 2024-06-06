import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wonder_beauties/application/home/pages/categories_page.dart';
import 'package:wonder_beauties/core/data/local_data/shared_pref.dart';
import 'package:wonder_beauties/core/utils/extensions/widget_extensions.dart';
import 'package:wonder_beauties/core/values/values.dart';

import '../../../core/values/constant.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    checkIsLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.splashScreenImageDir),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  void checkIsLoggedIn() {
    bool? isLoggedIn = getBoolAsync(ISLOGGEDIN);
    Timer(const Duration(milliseconds: 1500), () async {
      if (isLoggedIn == false) {
        const LoginPage(
          isLogout: true,
        ).launch(context, isNewTask: true);
      } else {
        const CategoriesScreen().launch(context, isNewTask: true);
      }
    });
  }
}
