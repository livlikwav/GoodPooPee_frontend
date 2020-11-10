import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gpp_app/screens/report/components/waiting_card.dart';
import 'package:gpp_app/screens/settings/screens/pad/pad_provider.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/empty_card.dart';
import 'package:provider/provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class LiveVideoThumbnail extends StatefulWidget {
  LiveVideoThumbnail(this.videoUrl);
  final String videoUrl;
  @override
  _LiveVideoThumbnailState createState() => _LiveVideoThumbnailState();
}

class _LiveVideoThumbnailState extends State<LiveVideoThumbnail> {
  PadProvider _padProvider;
  Future<Uint8List> image;
  // Horizontal:100 == screen Height
  final double _screenHeight = getBlockSizeHorizontal(100);

  @override
  void initState() {
    image = VideoThumbnail.thumbnailData(
      video: widget.videoUrl,
      imageFormat: ImageFormat.JPEG,
      maxWidth: getBlockSizeVertical(100)
          .toInt(), // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 100, // 0 - 100
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _padProvider = Provider.of<PadProvider>(context, listen: false);

    return FutureBuilder(
      future: image,
      builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
        Widget child;

        // Future complete with data
        if (snapshot.hasData) {
          child = Center(
            child: GestureDetector(
              onTapDown: (TapDownDetails details) {
                MyLogger.debug('Tapped ${details.globalPosition}');
                _padProvider.addPos(
                  posX: details.globalPosition.dx,
                  posY: details.globalPosition.dy,
                  screenHeight: _screenHeight,
                );
              },
              child: Container(
                height: _screenHeight,
                child: AspectRatio(
                  aspectRatio: _padProvider.videoRatio,
                  child: FittedBox(
                    child: Image.memory(snapshot.data),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          );
          // Future complete with error
        } else if (snapshot.hasError) {
          // Error error = snapshot.error;
          child = Center(
            child: EmptyCard(
              text: '스트리밍 요청 과정에서 오류가 발생하였습니다.',
            ),
          );
          // Future incomplete
        } else {
          child = Center(
            child: WaitingCard(),
          );
        }

        return child;
      },
    );
  }
}
