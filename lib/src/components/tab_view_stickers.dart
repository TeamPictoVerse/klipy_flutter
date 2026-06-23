import 'package:flutter/material.dart';
import 'package:klipy_flutter/src/utilities/is_tablet.dart';
import 'package:klipy_flutter/klipy_flutter.dart';

class KlipyViewStickers extends StatelessWidget {
  final KlipyClient client;
  final int? gifsPerRow;
  final KlipyTabViewStyle style;
  final List<KlipyMediaFormat>? media;

  const KlipyViewStickers({
    required this.client,
    this.gifsPerRow,
    this.style = const KlipyTabViewStyle(),
      this.media = const [KlipyMediaFormat.mediumGif, KlipyMediaFormat.tinyGifTransparent],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return KlipyTabView(
      client: client,
      gifsPerRow: gifsPerRow ?? (isTablet(context) ? 6 : 5),
      keepAliveTabView: true,
      onLoad: (queryText, pos, limit, category) async {
        if (queryText.isNotEmpty) {
          return await client.search(
            queryText,
            mediaFilter: media,
            pos: pos,
            limit: limit,
            sticker: true,
          );
        } else {
          return await client.featured(
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
