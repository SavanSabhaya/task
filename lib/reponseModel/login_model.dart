// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    bool? success;
    int? userId;
    String? firstName;
    String? lastName;
    String? primaryEmail;
    String? profileImageUrl;
    String? authToken;
    String? mobileNumber;
    int? rewardPoint;
    String? aliasId;
    String? saferPayToken;
    dynamic saferPayCardDetails;
    String? birthDate;

    LoginModel({
        this.success,
        this.userId,
        this.firstName,
        this.lastName,
        this.primaryEmail,
        this.profileImageUrl,
        this.authToken,
        this.mobileNumber,
        this.rewardPoint,
        this.aliasId,
        this.saferPayToken,
        this.saferPayCardDetails,
        this.birthDate,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        primaryEmail: json["primaryEmail"],
        profileImageUrl: json["profileImageURL"],
        authToken: json["authToken"],
        mobileNumber: json["mobileNumber"],
        rewardPoint: json["rewardPoint"],
        aliasId: json["aliasId"],
        saferPayToken: json["saferPayToken"],
        saferPayCardDetails: json["saferPayCardDetails"],
        birthDate: json["birthDate"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "primaryEmail": primaryEmail,
        "profileImageURL": profileImageUrl,
        "authToken": authToken,
        "mobileNumber": mobileNumber,
        "rewardPoint": rewardPoint,
        "aliasId": aliasId,
        "saferPayToken": saferPayToken,
        "saferPayCardDetails": saferPayCardDetails,
        "birthDate": birthDate,
    };
}
