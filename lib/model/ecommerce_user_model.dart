class userEcommerceModel {
  bool approved;
  String businessName;
  String emailAddress;
  String storeImage;
  String stateValue;
  String countryValue;
  String id;
  String cityValue;

  userEcommerceModel({
    required this.approved,
    required this.businessName,
    required this.emailAddress,
    required this.storeImage,
    required this.stateValue,
    required this.countryValue,
    required this.id,
    required this.cityValue,
  });
  userEcommerceModel.fromJson(Map<String, Object?> json)
      : this(
          approved: json['approved']! as bool,
          businessName: json['businessName']! as String,
          emailAddress: json['emailAddress']! as String,
          storeImage: json['storeImage']! as String,
          stateValue: json['stateValue']! as String,
          countryValue: json['countryValue,']! as String,
          id: json['id']! as String,
          cityValue: json['cityValue']! as String,
        );
  Map<String, Object?> tojson() {
    return {
      'approved': approved,
      'businessName': businessName,
      'emailAddress': emailAddress,
      'cityValue': cityValue,
      'countryValue': countryValue,
      'stateValue': stateValue,
      'storeImage': storeImage,
      'id': id,
    };
  }
}
