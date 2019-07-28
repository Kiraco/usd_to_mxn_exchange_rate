class ProviderModel {
  String _provider = "";
  String _value = "";
  String _updatedAt = "";

  void setUpdatedAt(String date) {
    _updatedAt = date;
  }

  void setProvider(String provider) {
    _provider = provider;
  }

  void setValue(String value) {
    _value = value;
  }

  String getProvider() {
    return _provider;
  }

  String getValue() {
    return _value;
  }

  String getUpdatedAt() {
    return _updatedAt;
  }
}
