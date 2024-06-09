import 'package:get/get.dart';

class MergeCategoryModel {
  dynamic success;
  List<Data>? data;
  dynamic baseUrl;
  dynamic message;
  dynamic selectedCategory = [].obs;
  // dynamic selectedSubCategory = [];
  dynamic isOpenSubCategory = 1000.obs;

  MergeCategoryModel({this.success, this.data, this.baseUrl, this.message});

  MergeCategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
    baseUrl = json['base_url'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['base_url'] = baseUrl;
    data['message'] = message;
    return data;
  }
}

class Data {
  dynamic id;
  dynamic categoryId;
  dynamic name;
  dynamic isSelectedCat= false.obs;
  // dynamic isShowSubCategory = false.obs;
  dynamic iconImage;
  dynamic createdAt;
  dynamic updatedAt;
  List<BaseCategoryArray>? baseCategoryArray;

  Data(
      {this.id,
        this.categoryId,
        this.name,
        this.iconImage,
        this.createdAt,
        this.updatedAt,
        this.baseCategoryArray});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    iconImage = json['icon_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['base_category_array'] != null) {
      baseCategoryArray = <BaseCategoryArray>[];
      json['base_category_array'].forEach((v) {
        baseCategoryArray!.add( BaseCategoryArray.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['category_id'] = categoryId;
    data['name'] = name;
    data['icon_image'] = iconImage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (baseCategoryArray != null) {
      data['base_category_array'] =
          baseCategoryArray!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BaseCategoryArray {
  dynamic id;
  dynamic categoryId;
  dynamic subCategoryId;
  dynamic name;
  dynamic isSelectedSubCat = false.obs;
  dynamic selectedSubCategory = [];
  dynamic iconImage;
  dynamic createdAt;
  dynamic updatedAt;

  BaseCategoryArray(
      {this.id,
        this.categoryId,
        this.subCategoryId,
        this.name,
        this.iconImage,
        this.createdAt,
        this.updatedAt});

  BaseCategoryArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    name = json['name'];
    iconImage = json['icon_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    data['name'] = name;
    data['icon_image'] = iconImage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
