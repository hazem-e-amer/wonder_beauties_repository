import 'dart:async';

import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wonder_beauties/application/home/bloc/categories_bloc/categories_bloc.dart';
import 'package:wonder_beauties/core/utils/extensions/context_extensions.dart';
import 'package:wonder_beauties/core/utils/extensions/widget_extensions.dart';
import 'package:wonder_beauties/core/values/values.dart';

import '../../../core/data/local_data/shared_pref.dart';
import '../../../core/utils/common.dart';
import '../../../core/utils/functions.dart';
import '../../../core/values/constant.dart';
import '../../authentication/pages/login_page.dart';

class ProductDetailsPage extends StatefulWidget {
  final String id;

  const ProductDetailsPage({super.key, required this.id});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void initState() {
    BlocProvider.of<CategoriesBloc>(context)
        .add(GetProductDetailsById(id: widget.id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Product Details',
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
          if (state.isLoading!) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          } else {
            if (state.product != null) {
              return DraggableHome(
                curvedBodyRadius: 0,
                headerExpandedHeight: 0.45,
                leading: Container(),
                stretchMaxHeight: 0.75,
                backgroundColor: Colors.white,
                expandedBody: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: (state.product!.image != null)
                        ? DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(state.product!.image ?? ""),
                          )
                        : const DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(ImagePath.brokenImageDir),
                          ),
                  ),
                ),
                fullyStretchable: true,
                title: Text(
                  state.product!.title ?? '',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),
                ),
                headerWidget: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 15.h),
                  decoration: BoxDecoration(
                    image: (state.product!.image != null)
                        ? DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(state.product!.image ?? ""),
                          )
                        : const DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(ImagePath.brokenImageDir),
                          ),
                  ),
                ),
                body: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.product!.title != null
                                ? state.product!.title!
                                : "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 19.sp,
                            ),
                          ),
                          Text(
                            state.product!.description != null
                                ? state.product!.description!
                                : "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 17.sp,
                            ),
                          ),
                          Text(
                            state.product!.price != null
                                ? '${state.product!.price.toString()} \$'
                                : "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: (state.product!.rating != null &&
                                    state.product!.rating!.rate != null)
                                ? state.product!.rating!.rate!
                                : 0.0,
                            minRating: 0.0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            unratedColor: Colors.grey,
                            onRatingUpdate: (double value) {},
                            ignoreGestures: true,
                            itemSize: 25.0,
                          ),
                          Text(
                            state.product!.category != null
                                ? state.product!.category!
                                : "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          }
        },
      ),
    );
  }
}
