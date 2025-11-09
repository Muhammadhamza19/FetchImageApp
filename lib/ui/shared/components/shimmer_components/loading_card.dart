import 'package:image_app/support/config/app_color.dart';
import 'package:image_app/ui/shared/components/shimmer_components/box_size.dart';
import 'package:image_app/ui/shared/components/shimmer_components/loading_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:image_app/ui/shared/components/shimmer_components/shimmer_widget.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    const row = Padding(
      padding: EdgeInsets.only(left: 16.0, top: 6.0, bottom: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Box.text(width: BoxSize.quarter, fontSize: 12.0),
                Box.text(width: BoxSize.quarter, fontSize: 12.0),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Box.text(width: BoxSize.quarter, fontSize: 12.0),
                Box.text(width: BoxSize.quarter, fontSize: 12.0),
              ],
            ),
          ),
        ],
      ),
    );
    return ShimmerWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const LoadingListTile(compact: true),
          Divider(color: secondaryColor, height: 0.0),
          row,
          Divider(color: secondaryColor, height: 0.0),
          row,
          const SizedBox(height: 4.0)
        ],
      ),
    );
  }
}
