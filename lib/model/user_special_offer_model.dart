class UserSpecialOfferModel {
  int? id;
  String? categoryId;
  String? userId;
  String? status;
  String? experience;
  String? offerCount;
  String? avgRating;
  String? imageUrl;
  Category? category;
  List<ExpertSubcats>? expertSubcats;
  List<Offers>? offers;
  User? user;

  UserSpecialOfferModel(
      {this.id,
        this.categoryId,
        this.userId,
        this.status,
        this.experience,
        this.offerCount,
        this.avgRating,
        this.imageUrl,
        this.category,
        this.offers,
        this.expertSubcats,
        this.user});

  UserSpecialOfferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    userId = json['user_id'];
    status = json['status'];
    experience = json['experience'];
    offerCount = json['offer_count'];
    avgRating = json['avg_rating'];
    imageUrl = json['image_url'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    if (json['expert_subcats'] != null) {
      expertSubcats = <ExpertSubcats>[];
      json['expert_subcats'].forEach((v) {
        expertSubcats!.add( ExpertSubcats.fromJson(v));
      });
    }
    if (json['offers'] != null) {
      offers = <Offers>[];
      json['offers'].forEach((v) {
        offers!.add( Offers.fromJson(v));
      });
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['experience'] = this.experience;
    data['offer_count'] = this.offerCount;
    data['avg_rating'] = this.avgRating;
    data['image_url'] = this.imageUrl;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (expertSubcats != null) {
      data['expert_subcats'] =
          expertSubcats!.map((v) => v.toJson()).toList();
    }
    if (offers != null) {
      data['offers'] = offers!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ExpertSubcats {
  dynamic name;
  dynamic expertId;

  ExpertSubcats({this.name, this.expertId});

  ExpertSubcats.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    expertId = json['expert_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['expert_id'] = expertId;
    return data;
  }
}

class Offers {
  dynamic id;
  dynamic expertId;
  dynamic banner;
  dynamic type;
  dynamic startDate;
  dynamic startTime;
  dynamic endDate;
  dynamic endTime;
  dynamic description;
  dynamic categoryId;
  dynamic discountPecent;
  dynamic isFeature;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  Offers(
      {this.id,
        this.expertId,
        this.banner,
        this.type,
        this.startDate,
        this.startTime,
        this.endDate,
        this.endTime,
        this.description,
        this.categoryId,
        this.discountPecent,
        this.isFeature,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expertId = json['expert_id'];
    banner = json['banner'];
    type = json['type'];
    startDate = json['start_date'];
    startTime = json['start_time'];
    endDate = json['end_date'];
    endTime = json['end_time'];
    description = json['description'];
    categoryId = json['category_id'];
    discountPecent = json['discount_pecent'];
    isFeature = json['is_feature'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['expert_id'] = expertId;
    data['banner'] = banner;
    data['type'] = type;
    data['start_date'] = startDate;
    data['start_time'] = startTime;
    data['end_date'] = endDate;
    data['end_time'] = endTime;
    data['description'] = description;
    data['category_id'] = categoryId;
    data['discount_pecent'] = discountPecent;
    data['is_feature'] = isFeature;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? status;
  String? address;
  String? userType;
  String? isAdmin;
  String? email;
  String? phonecode;
  String? mobile;
  String? mobileApi;
  String? profilePicture;
  String? isVerified;
  String? accountStatus;
  String? distance;
  String? lat;
  String? lng;

  User(
      {this.id,
        this.name,
        this.status,
        this.address,
        this.userType,
        this.isAdmin,
        this.email,
        this.phonecode,
        this.mobile,
        this.mobileApi,
        this.profilePicture,
        this.isVerified,
        this.accountStatus,
        this.distance,
        this.lat,
        this.lng});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    address = json['address'];
    userType = json['user_type'];
    isAdmin = json['is_admin'];
    email = json['email'];
    phonecode = json['phonecode'];
    mobile = json['mobile'];
    mobileApi = json['mobile_api'];
    profilePicture = json['profile_picture'];
    isVerified = json['is_verified'];
    accountStatus = json['account_status'];
    distance = json['distance'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['address'] = this.address;
    data['user_type'] = this.userType;
    data['is_admin'] = this.isAdmin;
    data['email'] = this.email;
    data['phonecode'] = this.phonecode;
    data['mobile'] = this.mobile;
    data['mobile_api'] = this.mobileApi;
    data['profile_picture'] = this.profilePicture;
    data['is_verified'] = this.isVerified;
    data['account_status'] = this.accountStatus;
    data['distance'] = this.distance;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
