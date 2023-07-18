import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/api/api_settings.dart';
import 'package:food_delivery/api/recommended_api_controller.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import '../../models/popular_food_model.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text.dart';

class RecommendedFoodDetails extends StatelessWidget {
  int pageId;
   RecommendedFoodDetails({required this.pageId,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Products>>(
        future: RecommendedApiController().getListOfRecommendedProducts(),
        builder: (context,snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else if(snapshot.hasData&&snapshot.data!.isNotEmpty) {
            return CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: 70.h,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap:(){
                        Navigator.pushNamed(context, '/home');
                      },
                        child: const AppIcon(icon: Icons.clear, backgroundColor: AppColors.signColor)),
                    AppIcon(icon: Icons.shopping_cart, backgroundColor: AppColors.signColor),

                  ],
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(20),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 5.h,
                    bottom: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                      ),
                    ),
                    child: Center(
                      child: BigText(text: snapshot.data![pageId].name!),
                    ),
                  ),
                ),
                pinned: true,
                backgroundColor: AppColors.yellowColor,
                expandedHeight: 300.h,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                  ApiSettings.baseUri+"/uploads/"+snapshot.data![pageId].img!,
                  width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h ),
                  child:  ExpandableText(
                      text: snapshot.data![pageId].description!
                  ),
                ),
              )
            ],
          );
          } else {
            return BigText(text: "No Data");
          }
        }
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child:  FutureBuilder<List<Products>>(
    future: RecommendedApiController().getListOfRecommendedProducts(),
    builder: (context,snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppIcon(
                    icon: Icons.remove, backgroundColor: AppColors.mainColor),
                BigText(text: "\$${snapshot.data![pageId].price!}" + " X " +
                    "0",),
                AppIcon(icon: Icons.add, backgroundColor: AppColors.mainColor,),

              ],
            ),
            SizedBox(height: 30.h,),
            Container(
              margin: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 15.h, left: 10.w, right: 10.w, bottom: 15.h),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r)
                    ),
                    child: Icon(Icons.favorite, color: AppColors.mainColor,),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 15.h, left: 10.w, right: 10.w, bottom: 15.h),
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(20.r)
                    ),
                    child: BigText(text: "\$${snapshot.data![pageId]
                        .price!}| add to your cart", color: Colors.white,),
                  )
                ],
              ),
            )
          ],
        );
      }
      else
        return BigText(text: "No Data");
    }),
    )
    );
  }
}
