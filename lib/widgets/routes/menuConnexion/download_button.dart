import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_plan/widgets/routes/menuConnexion/download_service.dart';
import 'package:web_plan/widgets/routes/menuConnexion/mobile_download.dart';
import 'package:web_plan/widgets/routes/menuConnexion/web_download.dart';

class DownloadButton extends StatefulWidget {
  final String url;
  const DownloadButton({Key? key, required this.url}) : super(key: key);

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {

  Future<void> _downloadFile() async {
    DownloadService downloadService = 
        kIsWeb ? MyWebDownloadService() : MyMobileDownloadService();
    await downloadService.download(url: widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _downloadFile,
      icon: const Icon(Icons.download),
      label: const Text('Télécharger l\'APK mobile.'),
      style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromRGBO(36, 45, 165, 1)),
                  ),
    );
  }
}