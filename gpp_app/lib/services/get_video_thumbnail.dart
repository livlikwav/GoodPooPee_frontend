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
  Future<Uint8List> image;
  @override
  void initState() {
    image = VideoThumbnail.thumbnailData(
      video: widget.videoUrl,
      imageFormat: ImageFormat.JPEG,
      maxWidth: getBlockSizeVertical(100)
          .toInt(), // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 25,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  Provider.of<PadProvider>(context, listen: false).add(
                    details.globalPosition.dx,
                    details.globalPosition.dy,
                  );
                },
                child: Image.memory(snapshot.data)),
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
            child: WaitingCard(
              text: '데이터를 불러오는 중입니다.',
            ),
          );
        }

        return child;
      },
    );
  }
}
