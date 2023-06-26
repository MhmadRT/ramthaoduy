import 'dart:convert';

String addDeathsRequestToJson(AddDeathsRequest data) =>
    json.encode(data.toJson());

class AddDeathsRequest {
  String? cityId;
  String? deadName;
  String? gender;
  String? birthDate;

  String? buryDescription;
  String? latatude;
  String? longitude;
  String? description;
  String? phoneNumber;
  String? nameOfRequester;

  AddDeathsRequest({
    this.cityId,
    this.deadName,
    this.gender,
    this.birthDate,

    this.buryDescription,
    this.latatude,
    this.longitude,
    this.description,
    this.phoneNumber,
    this.nameOfRequester,
  });
  Map<String, String> toJson() => {
        "city_id": cityId ?? "",
        "dead_name": deadName ?? "",
        "gender": gender ?? "",
        "birth_date": birthDate ?? "",
         "bury_description": buryDescription ?? "",
        "latatude": latatude ?? "",
        "longitude": longitude ?? "",
        "description": description ?? "",
        "phone_number": phoneNumber ?? "",
        "name_of_requester": nameOfRequester ?? "",
      };
}
