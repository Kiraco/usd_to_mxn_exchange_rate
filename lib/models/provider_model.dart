class ProviderModel {
  String _id = "";
  String _name = "";
  String _rate = "";
  String _updatedAt = "";

  void setUpdatedAt(String date) {
    _updatedAt = date;
  }

  void setName(String provider) {
    _name = provider;
  }

  void setRate(String value) {
    _rate = value;
  }

  String getName() {
    return _name;
  }

  String getRate() {
    return _rate;
  }

  String getUpdatedAt() {
    return _updatedAt;
  }

  ProviderModel.fromJson(Map json)
      : _id = json['ID'],
        _name = json['Name'],
        _rate = json['Rate'],
        _updatedAt = json['UpdatedAt'];

  Map toJson() {
    return {'ID': _id, 'Name': _name, 'Rate': _rate, 'UpdatedAt': _updatedAt};
  }

  String toString() {
    return "{\"ID\":\"" +
        _id +
        "\", \"Name\":\"" +
        _name +
        "\", \"Rate\":\"" +
        _rate +
        "\", \"UpdatedAt\":\"" +
        _updatedAt +
        "\"}";
  }
}
