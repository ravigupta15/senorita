import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senorita/helper/appbar.dart';
import 'package:senorita/helper/searchbar.dart';
import 'package:senorita/widget/no_data_found.dart';

import '../../../ScreenRoutes/routes.dart';
import '../../../widget/view_salon_widget.dart';
import 'controller/search_controller.dart';

class SearchScreen extends GetView<SearchSalonController>{


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: appBar(context, 'Search', () {
        Get.back();
      }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          searchBar(readOnly: false,onChanged: (val){
            controller.isSearch.value = true;
              controller.allHomeScreenApiFunction(val);
             },
          ),
          Expanded(child: Obx(()=>
          controller.searchList.isEmpty&&controller.isSearch.value?
              noDataFound():
              ListView.separated(
                separatorBuilder: (context,sp){
                  return const SizedBox(height: 23,);
                },
                padding:const EdgeInsets.only(left: 15,right: 14,top: 20,bottom: 40),
                shrinkWrap: true,
                itemCount: controller.searchList.length,
                physics:const ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  var model = controller.searchList[index];
                  return viewSalonWidget(context, model, controller.imgBaseUrl.value,() {
                    Get.toNamed(AppRoutes.categoryDetailsScreen, arguments: [
                      model['user']['id'].toString(),
                      controller.lat.value.toString(),
                      controller.long.value.toString(),
                    ]);
                  });
                }
            ),
          ),
          )
        ],
      ),
    );
  }
}