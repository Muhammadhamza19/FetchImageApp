import 'package:image_app/support/config/app_theme.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';

class MyNetworkImage extends StatelessWidget {
  final String url;

  const MyNetworkImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return FastCachedImage(
        url: "https://www.sefram.com/images/products/photos/hi_res/7202.jpg",
        fit: BoxFit.cover,
        fadeInDuration: const Duration(seconds: 1),
        errorBuilder: (context, exception, stacktrace) {
          return Text(stacktrace.toString());
        },
        loadingBuilder: (context, progress) {
          return Container(
            color: Colors.yellow,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (progress.isDownloading && progress.totalBytes != null)
                  Text(
                      '${progress.downloadedBytes ~/ 1024} / ${progress.totalBytes! ~/ 1024} kb',
                      style: textStyle(color: Colors.red)),
                SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                        color: Colors.red,
                        value: progress.progressPercentage.value)),
              ],
            ),
          );
        });
  }
}
