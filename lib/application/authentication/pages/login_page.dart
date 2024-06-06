import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wonder_beauties/application/authentication/widgets/double_press_back_widget.dart';
import 'package:wonder_beauties/application/home/pages/categories_page.dart';
import 'package:wonder_beauties/core/data/local_data/shared_pref.dart';
import 'package:wonder_beauties/core/utils/auth_services/auth_services.dart';
import 'package:wonder_beauties/core/utils/common.dart';
import 'package:wonder_beauties/core/utils/extensions/widget_extensions.dart';
import 'package:wonder_beauties/core/utils/functions.dart';
import 'package:wonder_beauties/core/values/constant.dart';
import 'package:wonder_beauties/core/values/values.dart';

const List<Map<String, String>> accounts = [
  {
    'userName': 'hazem1',
    'password': '1234561',
  },
  {
    'userName': 'hazem2',
    'password': '1234562',
  },
  {
    'userName': 'hazem3',
    'password': '1234563',
  },
];

class LoginPage extends StatefulWidget {
  final bool? isLogout;

  const LoginPage({
    Key? key,
    required this.isLogout,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? userName;
  String? password;
  bool rememberMe = false;
  bool showPassword = false;

  @override
  void initState() {
    if (widget.isLogout != null) {
      if (widget.isLogout == true &&
          getBoolAsync(REMEMPERME) != false &&
          getStringAsync(USERNAME) != '' &&
          getStringAsync(PASSWORD) != '') {
        userName = getStringAsync(USERNAME);
        password = getStringAsync(PASSWORD);
      } else {
        setValue(REMEMPERME, false);
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DoublePressBackWidget(
      child: Scaffold(
        backgroundColor: Colors.green,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 120.h, horizontal: 15.w),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                height: 50.h,
                margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.sp),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 1,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                      child: Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 25.sp,
                      ),
                    ),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: userName,
                          hint: Text(
                            'User name',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.grey,
                            ),
                          ),
                          iconDisabledColor: Colors.transparent,
                          iconEnabledColor: Colors.transparent,
                          isDense: true,
                          isExpanded: true,
                          padding: EdgeInsets.zero,
                          items: accounts
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e['userName'],
                                  child: Text(
                                    e['userName']!,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              userName = value;
                              password = accounts
                                  .elementAt(accounts.indexWhere((element) {
                                if (element['userName'] == value) {
                                  return true;
                                } else {
                                  return false;
                                }
                              }))['password'];
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50.h,
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.sp),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 1,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                      child: Icon(
                        Icons.lock,
                        color: Colors.black,
                        size: 25.sp,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 9.w),
                        child: Text(
                          password != null
                              ? showPassword
                                  ? password!
                                  : '*******'
                              : 'Password',
                          style: TextStyle(
                            fontSize: password != null ? 15.sp : 13.sp,
                            color:
                                password != null ? Colors.black : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        child: Icon(
                          showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                          size: 25.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  children: [
                    Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        side: const BorderSide(color: Colors.white),
                        checkColor: Colors.green,
                        activeColor: Colors.white,
                        value: getBoolAsync(REMEMPERME).toString() == ''
                            ? rememberMe
                            : getBoolAsync(REMEMPERME) == true
                                ? true
                                : false,
                        onChanged: (v) {
                          setState(() {
                            if (v == true) {
                              setValue(REMEMPERME, true);
                            } else {
                              setValue(REMEMPERME, false);
                            }
                            rememberMe = !rememberMe;
                          });
                        }),
                    Expanded(
                      child: Text(
                        "Remember me",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (userName != null && password != null) {
                    Functions.showLoaderFunction(context: context);
                    Timer(const Duration(milliseconds: 3000), () {
                      const CategoriesScreen().launch(context, isNewTask: true);
                      setValue(USERNAME, userName);
                      setValue(PASSWORD, password);
                      setValue(ISLOGGEDIN, true);
                    });
                  } else {
                    toast(
                      "Check user name or password",
                      bgColor: Colors.white,
                      textColor: Colors.green,
                    );
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 60.h),
                  alignment: Alignment.center,
                  height: 50.h,
                  width: 175.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Text(
                "Or login with",
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  bool isAuthenticated = await AuthService.authenticateUser();
                  if (isAuthenticated) {
                    if (getStringAsync(USERNAME).isNotEmpty &&
                        getStringAsync(PASSWORD).isNotEmpty) {
                      Functions.showLoaderFunction(context: context);
                      Timer(const Duration(milliseconds: 3000), () {
                        const CategoriesScreen()
                            .launch(context, isNewTask: true);
                        setValue(ISLOGGEDIN, true);
                      });
                    } else {
                      toast(
                        "Check user name or password",
                        bgColor: Colors.white,
                        textColor: Colors.green,
                      );
                    }
                  } else {
                    toast(
                      "Your device is not supported",
                      bgColor: Colors.white,
                      textColor: Colors.green,
                    );
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 60.h),
                  child: SvgPicture.asset(
                    IconPath.fingerPrintIconDir,
                    width: 50.w,
                    height: 50.h,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
