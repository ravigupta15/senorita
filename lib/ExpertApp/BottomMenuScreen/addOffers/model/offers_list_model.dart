// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);
import 'dart:convert';

class OfferList {
  dynamic id;
  dynamic expert_id;
  dynamic banner;

  OfferList(
    this.id,
    this.expert_id,
    this.banner,
  );
}

