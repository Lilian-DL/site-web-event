import './mobile_download.dart';
import './web_download.dart';



abstract class DownloadService {
  Future<void> download({required String url});
}

class WebDownloadService implements DownloadService {
  @override
  Future<void> download({required String url}) {
    throw UnimplementedError();
  }
}

class MobileDownloadService implements DownloadService {
  @override
  Future<void> download({required String url}) {
    throw UnimplementedError();
  }
}