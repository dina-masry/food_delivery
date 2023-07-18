import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/small_text.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;
  bool isHidden = true;
  double textHeight = 200.h;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.text.length> textHeight){
      firstHalf = widget.text.substring(0,textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1, widget.text.length);

    }else{
      firstHalf= widget.text;
      secondHalf ="";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(text: firstHalf,height: 1.8.h,size: 15.sp,color: AppColors.paraColor,):
      Column(
        children: [
          SmallText(text: isHidden? ("$firstHalf...") :(firstHalf+secondHalf),height: 1.8.h,size: 15.sp,color: AppColors.paraColor),
          InkWell(
            onTap: (){
              setState(() {
                isHidden = !isHidden;
              });
            },
            child: Row(
              children: [
                SmallText(text: isHidden?"Show more":"Do not show",color: AppColors.mainColor,),
                Icon(isHidden?Icons.arrow_drop_down:Icons.arrow_drop_up,color: AppColors.mainColor,)
              ],
            ),
          )

        ],
      ),
    );
  }
}
