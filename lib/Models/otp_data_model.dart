class OtpDataModel {
  bool? status;
  String? response;
  String? requestId;

  OtpDataModel({this.status, this.response, this.requestId});

  OtpDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    requestId = json['request_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response'] = this.response;
    data['request_id'] = this.requestId;
    return data;
  }
}
