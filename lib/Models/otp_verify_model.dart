class OtpVerifyModel {
  bool? status;
  bool? profileExists;
  String? jwt;

  OtpVerifyModel({this.status, this.profileExists, this.jwt});

  OtpVerifyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    profileExists = json['profile_exists'];
    jwt = json['jwt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['profile_exists'] = this.profileExists;
    data['jwt'] = this.jwt;
    return data;
  }
}
