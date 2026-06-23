import 'package:flutter/material.dart';
import 'package:klipy_flutter/src/utilities/is_tablet.dart';
import 'package:klipy_flutter/klipy_flutter.dart';

class KlipyViewEmojis extends StatelessWidget {
  final KlipyClient client;
  final int? gifsPerRow;
  final KlipyTabViewStyle style;
  final List<KlipyMediaFormat>? media;


  const KlipyViewEmojis({
    required this.client,
    this.gifsPerRow,
    this.style = const KlipyTabViewStyle(),
    super.key,
    this.media = const [KlipyMediaFormat.mediumGif, KlipyMediaFormat.tinyGifTransparent],
  });

  @override
  Widget build(BuildContext context) {
    return KlipyTabView(
      client: client,
      gifsPerRow: gifsPerRow ?? (isTablet(context) ? 8 : 9),
      keepAliveTabView: true,
      onLoad: (queryText, pos, limit, category) async {
        if (queryText.isNotEmpty) {
          return await client.search(
            '$queryText emoji',
            mediaFilter: media,
            pos: pos,
            limit: limit,
            sticker: true,
          );
        } else {
          return await client.search(
            'emoji',
            mediaFilter: media,
            pos: pos,
            limit: limit,
            sticker: true,
          );
        }
      },
      style: style,
    );
  }
}
