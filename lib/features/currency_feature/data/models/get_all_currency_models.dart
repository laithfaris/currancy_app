class CurrenciesModels {
  String? flag;
  String? code;
  num? value;

  CurrenciesModels({this.flag, this.code, this.value});

  CurrenciesModels.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    code = json['code'];
    value = json['value'];
  }
}
