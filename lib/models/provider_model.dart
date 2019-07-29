class ProviderModel {
  String _provider = "";
  String _rate = "";
  String _updatedAt = "";

  void setUpdatedAt(String date) {
    _updatedAt = date;
  }

  void setProvider(String provider) {
    _provider = provider;
  }

  void setRate(String value) {
    _rate = value;
  }

  String getProvider() {
    return _provider;
  }

  String getRate() {
    return _rate;
  }

  String getUpdatedAt() {
    return _updatedAt;
  }
}
