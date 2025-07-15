// 웹이 아닌 플랫폼용 stub
class Window {
  void open(String url, String target) {
    // 모바일에서는 아무것도 하지 않음
  }
}

final window = Window();