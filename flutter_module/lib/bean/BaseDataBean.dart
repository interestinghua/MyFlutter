class BaseDataBean {
  num code;
  String detail;
  dynamic data;

  BaseDataBean.fromJson(Map<String, dynamic> json) {
    this.code = json['code'];
    this.detail = json['detail'];
    this.data = json['data'];
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'detail': detail,
    'data': data,
  };
}
