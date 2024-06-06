import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wonder_beauties/application/home/bloc/categories_bloc/categories_bloc.dart';
import 'package:wonder_beauties/application/home/pages/product_details_page.dart';
import 'package:wonder_beauties/application/home/widgets/category_widget.dart';
import 'package:wonder_beauties/application/home/widgets/product_widget.dart';
import 'package:wonder_beauties/core/utils/extensions/context_extensions.dart';
import 'package:wonder_beauties/core/utils/extensions/widget_extensions.dart';

import '../../../core/data/local_data/shared_pref.dart';
import '../../../core/utils/common.dart';
import '../../../core/utils/functions.dart';
import '../../../core/values/constant.dart';
import '../../authentication/pages/login_page.dart';

class ProductsPage extends StatefulWidget {
  String categoryName;

  ProductsPage({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    BlocProvider.of<CategoriesBloc>(context).add(GetCategoriesEvent());
    BlocProvider.of<CategoriesBloc>(context)
        .add(GetProductsEvent(categoryName: widget.categoryName));
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
          'Products',
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
      body: RefreshIndicator(
        color: Colors.green,
        onRefresh: () async {
          BlocProvider.of<CategoriesBloc>(context).add(GetCategoriesEvent());
          BlocProvider.of<CategoriesBloc>(context)
              .add(GetProductsEvent(categoryName: widget.categoryName));
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 15.h),
              child: BlocBuilder<CategoriesBloc, CategoriesState>(
                builder: (context, state) {
                  if (state.categories != null) {
                    return SizedBox(
                      height: 50.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => SizedBox(
                          width: 5.w,
                        ),
                        itemCount: state.categories!.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            if (state.categories != null) {
                              BlocProvider.of<CategoriesBloc>(context).add(
                                  GetProductsEvent(
                                      categoryName: state.categories![index]));
                            }
                            widget.categoryName = state.categories![index];
                          },
                          child: CategoryWidget(
                            isCheck:
                                state.categories![index] == widget.categoryName,
                            categoryName: state.categories![index],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
            BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                if (state.isLoading!) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    ),
                  );
                } else {
                  if (state.selectedList != null) {
                    return Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10.h,
                        ),
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            ProductDetailsPage(
                                    id: state.selectedList![index].id != null
                                        ? state.selectedList![index].id
                                            .toString()
                                        : "")
                                .launch(context,
                                    pageRouteAnimation:
                                        PageRouteAnimation.Rotate);
                          },
                          child: ProductWidget(
                              productModel: state.selectedList![index]),
                        ),
                        itemCount: state.selectedList!.length,
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
