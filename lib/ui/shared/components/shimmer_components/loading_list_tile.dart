import 'package:flutter/material.dart';
import 'package:image_app/ui/shared/components/shimmer_components/box_size.dart';
import 'package:image_app/ui/shared/components/shimmer_components/shimmer_widget.dart';

class LoadingListTile extends StatelessWidget {
  final bool showSubtitle;
  final bool showLeading;
  final bool showTrailing;
  final bool compact;

  const LoadingListTile({
    super.key,
    this.showSubtitle = true,
    this.showLeading = true,
    this.showTrailing = true,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: ListTile(
        visualDensity: compact ? VisualDensity.compact : VisualDensity.standard,
        title: const Box.text(fontSize: 15.0),
        subtitle: showSubtitle
            ? Row(
                children: [
                  const Expanded(child: Box.text(fontSize: 11.0)),
                  Expanded(child: Container())
                ],
              )
            : null,
        leading: showLeading
            ? const Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Box(explicitWidth: 20.0, explicitHeight: 20.0),
              )
            : null,
        trailing: showTrailing
            ? const Box(explicitWidth: 20.0, explicitHeight: 20.0)
            : null,
      ),
    );
  }
}
