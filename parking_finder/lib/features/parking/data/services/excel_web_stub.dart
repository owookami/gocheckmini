// 웹이 아닌 플랫폼용 stub
class AnchorElement {
  String? href;
  String? download;
  void click() {}
  void remove() {}
}

AnchorElement createElement(String tag) => AnchorElement();

class Url {
  static String createObjectUrlFromBlob(dynamic blob) => '';
  static void revokeObjectUrl(String url) {}
}

class Blob {
  Blob(List<dynamic> data, [String? type]);
}

final document = _Document();

class _Document {
  _Body? body = _Body();
  
  AnchorElement createElement(String tag) => AnchorElement();
  void append(dynamic element) {}
}

class _Body {
  void append(dynamic element) {}
}