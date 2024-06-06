import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wonder_beauties/application/authentication/pages/login_page.dart';
import 'package:wonder_beauties/application/home/bloc/categories_bloc/categories_bloc.dart';
import 'package:wonder_beauties/application/home/pages/products_page.dart';
import 'package:wonder_beauties/core/data/local_data/shared_pref.dart';
import 'package:wonder_beauties/core/utils/common.dart';
import 'package:wonder_beauties/core/utils/extensions/widget_extensions.dart';
import 'package:wonder_beauties/core/utils/functions.dart';
import 'package:wonder_beauties/core/values/constant.dart';
import 'package:wonder_beauties/core/values/values.dart';

import '../../authentication/widgets/double_press_back_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoriesBloc>(context).add(GetCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DoublePressBackWidget(
      bgColor: Colors.green,
      textColor: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            'Categories',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Functions.showDialogFunction(
                  context: context,
                  data: 'Are you sure to logout?',
                  onTapYes: () {
                    Functions.showLoaderFunction(context: context);
                    Timer(const Duration(milliseconds: 3000), () {
                      const LoginPage(isLogout: true).launch(context,
                          isNewTask: true,
                          pageRouteAnimation: PageRouteAnimation.Rotate);
                      setValue(ISLOGGEDIN, false);
                    });
                  },
                );
              },
              icon: const Icon(Icons.logout),
              color: Colors.white,
            )
          ],
        ),
        body: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            if (state.isLoading != null && state.isLoading!) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            } else {
              if (state.categories != null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: GridView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          shrinkWrap: true,
                          itemCount: state.categories!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15.w,
                            mainAxisSpacing: 15.h,
                          ),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              ProductsPage(
                                categoryName: state.categories![index],
                              ).launch(context,
                                  pageRouteAnimation:
                                      PageRouteAnimation.Rotate);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(15.sp),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.green,
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  state.categories![index] ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Image.asset(ImagePath.noInternetConnectionImageDir),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
