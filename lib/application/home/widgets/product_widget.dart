import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wonder_beauties/application/home/models/product_model.dart';
import 'package:wonder_beauties/core/values/values.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel productModel;

  const ProductWidget({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
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
      height: 150.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Image.network(
              productModel.image ?? '',
              fit: BoxFit.fill,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  period: const Duration(milliseconds: 3000),
                  child: Container(
                    color: Colors.white,
                  ),
                );
              },
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Image.asset(ImagePath.brokenImageDir);
              },
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Expanded(
                  child: Text(
                    (productModel.title != null &&
                            productModel.title!.length > 10)
                        ? "${productModel.title!.substring(0, 10)}..."
                        : productModel.title ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    (productModel.description != null &&
                            productModel.description!.length > 20)
                        ? "${productModel.description!.substring(0, 20)}..."
                        : productModel.description ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.normal,
                      fontSize: 13.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    (productModel.price != null)
                        ? '${productModel.price!.toString()} \$'
                        : "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: RatingBar.builder(
                    initialRating: (productModel.rating != null &&
                            productModel.rating!.rate != null)
                        ? productModel.rating!.rate!
                        : 0.0,
                    minRating: 0.0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    unratedColor: Colors.white,
                    onRatingUpdate: (double value) {},
                    ignoreGestures: true,
                    itemSize: 25.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
