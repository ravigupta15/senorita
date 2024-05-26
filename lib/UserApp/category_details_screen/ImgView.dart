import 'dart:async';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

import '../../api_config/Api_Url.dart';
import '../../helper/appimage.dart';
import '../../utils/color_constant.dart';
import 'indication.dart';

class ImgView extends StatefulWidget {
  final List imgList;
  const ImgView(this.imgList, {super.key});
  @override
  State<ImgView> createState() => _ImgViewState();
}
class _ImgViewState extends State<ImgView> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.blackColor,
        elevation: 0,
        leadingWidth: 30,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
              height: 28,
              width: 28,
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(
                    AppImages.backIcon,
                    height: 28,
                    color: Colors.white,
                    width: 28,
                  ))),
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                  itemCount: widget.imgList.length,
                  onPageChanged: (val) {
                    index = val;
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10,bottom: 10),
                      child: GestureDetector(
                        onTap: () {

                        },
                        child: PhotoView(
                          minScale: PhotoViewComputedScale.contained * 0.5,
                          disableGestures: true,
                          backgroundDecoration: const BoxDecoration(color: Colors.transparent,),
                          imageProvider: NetworkImage(ApiUrls.offerImageBase + widget.imgList[index].banner.toString()
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(widget.imgList.length, (i) => Indicator(index == i ? true : false))),
          ],
        ),
      ),
    );
  }

}
