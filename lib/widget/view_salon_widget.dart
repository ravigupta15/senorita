

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import '../helper/appimage.dart';
import '../helper/getText.dart';
import '../utils/color_constant.dart';
import '../utils/my_sperator.dart';
import '../utils/stringConstants.dart';

viewSalonWidget(BuildContext context, model, String imgBaseUrl, Function()onTap) {

  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          color: ColorConstant.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset:const Offset(0, -2),
                color: ColorConstant.blackColor.withOpacity(.2),
                blurRadius: 10
            )
          ]
      ),
      padding: const EdgeInsets.only(bottom: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstant.white,
                ),
                child: ClipRRect(
                  borderRadius:const BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8)),
                  child: /*Image.network(
                      controller.listing_base_url.value+model['user']['profile_picture'].toString(),
                      height: 295,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),*/
                  model['user']!=null?   CachedNetworkImage(
                    height: 200,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    imageUrl: imgBaseUrl+
                        model['user']['profile_picture'].toString(),
                    errorWidget: (context, url, error) =>
                        Image.network(
                          "https://raysensenbach.com/wp-content/uploads/2013/04/default.jpg",
                          height: 250,
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width,
                        ),
                  ): Image.network(
                    "https://raysensenbach.com/wp-content/uploads/2013/04/default.jpg",
                    height: 250,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 11,right: 12,top: 8,bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                softWrap: true,
                                model['user']!=null?
                                model['user']['name'].toString():"",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontFamily: interSemiBold,
                                  color: ColorConstant.blackColorDark,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 3,),
                              model['expert_subcats'] != null &&
                                  model['expert_subcats'] != "null"
                                  ? getText(
                                  title: model['expert_subcats'].map((subcat)=>subcat['name']).join(', ')?? '',
                                  size: 13,
                                  fontFamily: interMedium,
                                  color: ColorConstant.blackLight,
                                  fontWeight: FontWeight.w500)
                                  : SizedBox(),
                            ],
                          ),
                        ),
                        Container(
                          decoration:const BoxDecoration(
                            color: ColorConstant.greenStar,
                            borderRadius: BorderRadius.all(
                                Radius.circular(4)),),
                          padding:const EdgeInsets.only(left: 5,right: 4,top: 3,bottom: 4),
                          child: Row(
                            children: [
                              getText(
                                  title:
                                  model['avg_rating']==null?'0.0':
                                  model['avg_rating'].toString().contains('.')?
                                  model['avg_rating'].toString():"${model['avg_rating'].toString()}.0",
                                  size: 13,
                                  fontFamily: interMedium,
                                  color: ColorConstant.white,
                                  fontWeight: FontWeight.w500),
                              const SizedBox(
                                width: 2,
                              ),
                              Image.asset(
                                width: 10,
                                height: 10,
                                color: ColorConstant.white,
                                AppImages.rating,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2,),
                  ],
                ),
              ),
              model['user']!=null&& model['user']['address'] != null &&
                  model['user']['address'] != "null"
                  ? Padding(
                padding: const EdgeInsets.only(left: 11,right: 12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          width: 18,
                          height: 18,
                          AppImages.location,
                        ),
                        const  SizedBox(
                          width: 3,
                        ),
                        Flexible(
                          child: Text(
                            model['user']!=null? model['user']['address'].toString():'',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 13.0,
                              fontFamily: interMedium,
                              color: ColorConstant.blackLight,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              )
                  :const SizedBox(),
              model['user']!=null&&model['user']['lat'] != null &&
                  model['user']['lat'] != "null"
                  ? Padding(
                padding: const EdgeInsets.only(left: 11,right: 12, top: 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          width: 13,
                          color: ColorConstant.blackLight,
                          height: 13,
                          AppImages.distance,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Flexible(
                          child: Text(
                            " " +
                                model['user']['distance']
                                    .toString() +
                                " km",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 13.0,
                              fontFamily: interMedium,
                              color: ColorConstant.blackLight,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
                  :const SizedBox(),
                const Padding(
                  padding:  EdgeInsets.only(left: 11, right: 12,top: 10),
                  child: MySeparator(color: Color(0xffD6D5D5)),
                ),
                Padding(
                padding:
                const EdgeInsets.only(left: 11, top: 11, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Exp. ",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: interMedium,
                            color: ColorConstant.pointBg,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "- ${model['experience'].toString()} year",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontFamily: interMedium,
                            color: ColorConstant.blackLight,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    int.parse(model['offer_count'].toString(),) <
                        0
                        ?
                    Row(
                      children: [
                        Image.asset(
                          width: 17,
                          height: 17,
                          AppImages.specialOffer,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "Special offer",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: interMedium,
                            color: ColorConstant.darkBlueColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                        : SizedBox(),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
