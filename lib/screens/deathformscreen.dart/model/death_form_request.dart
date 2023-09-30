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
  String? latatudeCondolencesMaleInfo;
  String? longitudeCondolencesMaleInfo;
  String? latatudeCondolencesFeMaleInfo;
  String? longitudeCondolencesFeMaleInfo;
  String? description;
  String? relationship;
  String? phoneNumber;
  String? nameOfRequester;

  AddDeathsRequest({
    this.cityId,
    this.relationship,
    this.latatudeCondolencesMaleInfo,
    this.longitudeCondolencesMaleInfo,
    this.latatudeCondolencesFeMaleInfo,
    this.longitudeCondolencesFeMaleInfo,
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
        "relationship": relationship ?? "",
        "latatudeCondolencesMaleInfo": latatudeCondolencesMaleInfo ?? "",
        "longitudeCondolencesMaleInfo": longitudeCondolencesMaleInfo ?? "",
        "latatudeCondolencesFeMaleInfo": latatudeCondolencesFeMaleInfo ?? "",
        "longitudeCondolencesFeMaleInfo": longitudeCondolencesFeMaleInfo ?? "",
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
