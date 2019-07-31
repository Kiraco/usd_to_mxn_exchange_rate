import 'dart:html';

class LocalStorage {
  final Storage _localStorage = window.localStorage;

  Future Save(String name, String data) async {
    _localStorage[name] = data;
  }

  Future<String> GetData(String name) async => _localStorage[name];

  Future Invalidate(String name) async {
    _localStorage.remove(name);
  }

  LocalStorage();
}
