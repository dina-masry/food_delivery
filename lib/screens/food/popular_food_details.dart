import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/api/api_settings.dart';
import 'package:food_delivery/api/popular_api_controller.dart';
import 'package:food_delivery/extensions/extension.dart';
import 'package:food_delivery/get/ProductsGetXController.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/AppColumn.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/expandable_text.dart';
import 'package:get/get.dart';

import '../../get/Popular_getx.dart';
import '../../get/cart_controller.dart';
import '../../models/popular_food_model.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icons_and_text_widgets.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetails extends StatefulWidget {
  final int pageId;
   PopularFoodDetails(this.pageId, {Key? key}) : super(key: key);
   PopularProductsGet controller = Get.put<PopularProductsGet>(PopularProductsGet());
  CartController cartController = Get.put<CartController>(CartController());
  //List<Products> products=[];
      // getList()async {
      //   List<Products> products =  await PopularApiController().getListOfProducts();
      //     this.products = products;
      // }

  @override
  State<PopularFoodDetails> createState() => _PopularFoodDetailsState();
}

class _PopularFoodDetailsState extends State<PopularFoodDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //PopularProductsGet.to.initProduct(ProductsGetXController().popularProductsList[widget.pageId],Get.find<CartController>());
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<List<Products>>(
          future: PopularApiController().getListOfProducts(),
          builder: (context,snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return Stack(
                children: [
                  Positioned(
                      left: 0,
                      right: 0,
                      child: Image.network(
                        ApiSettings.baseUri + "/uploads/" +
                            snapshot.data![widget.pageId].img!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 400.h,
                      )
                  ),
                  Positioned(
                      top: 45.h,
                      right: 20.h,
                      left: 20.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/home');

                              },
                              child: const AppIcon(icon: Icons.arrow_back_ios,
                                  backgroundColor: AppColors.signColor)),
                          AppIcon(icon: Icons.add_shopping_cart,
                              backgroundColor: AppColors.signColor)

                        ],
                      )
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      top: 300.h,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 15.w, right: 15.w, top: 20.h),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.r),
                              topLeft: Radius.circular(20.r),

                            )
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppColumn(text: snapshot.data![widget.pageId].name!),
                            SizedBox(height: 20.h,),
                            BigText(text: "Introduce"),
                            SizedBox(height: 20.h,),
                            Expanded(
                                child: SingleChildScrollView(
                                  child: ExpandableText(
                                      text: snapshot.data![widget.pageId].description!),
                                )
                            )
                          ],
                        ),
                      )
                  )
                ],
              );
            } else {
              return Center(child: BigText(text: "No Data"));
            }
          }),

        bottomNavigationBar:
        FutureBuilder<List<Products>>(
          future: PopularApiController().getListOfProducts(),
          builder: (context,snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if(snapshot.hasData&& snapshot.data!.isNotEmpty) {
              return Container(
              height: 120.h,
              padding: EdgeInsets.only(top: 30.h ,left: 20.w,right: 20.w, bottom: 20.h),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.r),
                  topLeft: Radius.circular(20.r),
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(top:15.h,left: 10.w,right: 10.w,bottom: 15.h),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r)
                    ),
                    child: GetBuilder<PopularProductsGet>(
                      init: PopularProductsGet(),
                      global: true,
                      builder: (PopularProductsGet controller) {
                        return Row(
                          children: [
                            InkWell(
                              onTap:(){
                                if(PopularProductsGet.to.count>=20){
                                  context.showSnackBar(message: 'Can`t increment more than 20 !');
                                }else {
                                  PopularProductsGet.to.increment();
                                }
                              },
                              child:  const Icon(Icons.add,color: AppColors.signColor,),
                            ),
                            SizedBox(width: 5.w,),
                            BigText(text: PopularProductsGet.to.inCartItems.toString()),
                            SizedBox(width: 5.w,),
                            InkWell(
                              onTap:(){
                                if(PopularProductsGet.to.count<=0){
                                  context.showSnackBar(message: 'Can`t decrement less than 0 !');
                                }else {
                                  PopularProductsGet.to.decrement();
                                }

                              },
                              child:  const Icon(Icons.remove, color: AppColors.signColor,),
                            ),

                          ],
                        );
                      }
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top:15.h,left: 10.w,right: 10.w,bottom: 15.h),
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(20.r)
                      ),
                      child:GestureDetector(
                        onTap: (){
                          PopularProductsGet.to.addItems(snapshot.data![widget.pageId]);
                        },
                          child: BigText(text: "\$${snapshot.data![widget.pageId].price!}| add to your cart",color: Colors.white,)),
                    )

                ],
              ),
            );
            } else {
              return Center(child: BigText(text: "No Data"));
            }
          }
        ),
      );
  }
}
