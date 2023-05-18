class WelcomeDataModel {
  bool? status;
  String? response;

  WelcomeDataModel({this.status, this.response});

  WelcomeDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response'] = this.response;
    return data;
  }
}
