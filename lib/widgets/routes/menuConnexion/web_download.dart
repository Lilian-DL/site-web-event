import 'package:universal_html/html.dart' as html;
import './download_service.dart';

class MyWebDownloadService implements DownloadService {
  @override
  Future<void> download({required String url}) async {
    html.window.open(url, "_blank");
  }
}
