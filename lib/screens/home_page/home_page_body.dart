import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/api/api_settings.dart';
import 'package:food_delivery/api/popular_api_controller.dart';
import 'package:food_delivery/api/recommended_api_controller.dart';
import 'package:food_delivery/models/popular_food_model.dart';
import 'package:food_delivery/screens/food/popular_food_details.dart';
import 'package:food_delivery/screens/food/recommended_food_details.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/AppColumn.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icons_and_text_widgets.dart';
import 'package:food_delivery/widgets/small_text.dart';
class HomePageBody extends StatefulWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  PageController pageController= PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  double _scaleFactor= 0.8;
  double _height = 220;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue= pageController.page!;
      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        // images and texts
           FutureBuilder<List<Products>>(
             future: PopularApiController().getListOfProducts(),
             builder: (context,snapshot){
               if(snapshot.connectionState== ConnectionState.waiting){
                 return const Center(child: CircularProgressIndicator(),);
               }
               else if(snapshot.hasData && snapshot.data!.isNotEmpty){
                 return  Container(
                height: 320.h,
              child: PageView.builder(
                controller: pageController,
                itemCount:snapshot.data!.length,
                    itemBuilder: (context, index){
                      return _buildPageItem(index,snapshot.data![index]);
                    }),
          );

               }else {
                 return BigText(text: "No Data");
               }

             }
           ),
        // dots
           FutureBuilder<List<Products>>(
          future: PopularApiController().getListOfProducts(),
          builder:(context,snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }else if(snapshot.hasData && snapshot.data!.isNotEmpty) {
              return DotsIndicator(
    dotsCount: snapshot.data!.isEmpty?1:snapshot.data!.length,
    position: _currentPageValue,
    decorator: DotsDecorator(
    activeColor: AppColors.mainColor,
    size: const Size.square(9.0),
    activeSize: const Size(18.0, 9.0),
    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0.r)),
    ),
    );
            } else {
              return BigText(text: "No Data");
            }
          }
    ),

       // popular text
           Container(
      margin: EdgeInsets.only(left: 30.w),
      child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
      BigText(text: "Recommended"),
      SizedBox(width: 10.w,),
                Container(
                  margin: EdgeInsets.only(bottom: 3.h),
                    child: BigText(text: "." , color: Colors.black26,)),
                SizedBox(width: 10.w,),
                Container(
                  margin: EdgeInsets.only(bottom: 2.h),
                  child: SmallText(text:"Food pairing"),
                )

              ],
            ),
          ),

        //list of foods
        FutureBuilder<List<Products>>(
          future: RecommendedApiController().getListOfRecommendedProducts(),
            builder: (context, snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }else if(snapshot.hasData&&snapshot.data!.isNotEmpty){
              return  ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  physics:const  NeverScrollableScrollPhysics(),
                  itemBuilder: (context , index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>RecommendedFoodDetails(pageId: index)));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20.w, right: 20.w,bottom: 10.h),
                        child: Row(
                          children: [
                            //image section
                            Container(
                              width: 120.w,
                              height: 120.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: Colors.white30,
                                  image:  DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          ApiSettings.baseUri+"/uploads/"+snapshot.data![index].img!
                                      )
                                  )
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 100.h,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topRight:Radius.circular(20.r),
                                        bottomRight:Radius.circular(20.r) )
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.w, right: 10.r),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      BigText(text: snapshot.data![index].name!),
                                      SizedBox(height: 10.h,),
                                      SmallText(text: "with China characteristic"),
                                      SizedBox(height: 10.h,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          IconsAndTextWidget(icon: Icons.circle_sharp, text: "Normal", iconColor: AppColors.iconColor1),
                                          IconsAndTextWidget(icon: Icons.location_on, text: "1.7km", iconColor: AppColors.mainColor),
                                          IconsAndTextWidget(icon: Icons.access_time_rounded, text: "32min", iconColor: AppColors.iconColor2)

                                        ],
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }else{
              return BigText(text: "No Data");
            }
            }),

      ],
    );}

  Widget _buildPageItem(int index , Products products){
    Matrix4 matrix = Matrix4.identity();
    if(index == _currentPageValue.floor()){
      var currScale = 1-(_currentPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    }
    else if(index==_currentPageValue.floor()+1){
      var currScale = _scaleFactor+(_currentPageValue-index+1)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    }
    else if(index== _currentPageValue.floor()-1){
      var currScale = 1-(_currentPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }
    else{
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);
    }

    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=>PopularFoodDetails(index)));
        },
        child: Stack(
          children:[
            Container(
            height: 220.h,
            margin: EdgeInsets.only(left: 10.w,right: 10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: Colors.amber,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "${ApiSettings.baseUri}/uploads/${products.img!}"
                )
              )
            ),
          ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Container(
                height: 120.h,
                margin: EdgeInsets.only(left: 30.w,right: 30.w, bottom: 30.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0,5)
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5,0)
                    ),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5,0)
                    ),
                  ]
                ),
                child: Container(
                  padding: EdgeInsets.only(top:10.h , left:15.w, right: 15.w),
                  child: AppColumn(text:products.name!)
                ),
              ),
            ),
        ]),
      ),
    );
  }
}
