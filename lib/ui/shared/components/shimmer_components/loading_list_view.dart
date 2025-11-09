import 'package:image_app/ui/shared/components/shimmer_components/loading_list_tile.dart';
import 'package:flutter/material.dart';

/// Simple wrapper for a "Loading ListView"
/// The "Shimmer" effect will have to be added to the actual list item
/// as it doesn't work well here AND we can have a prettier UI if each
/// list item (eg Card) has it's own logic for coping with a loading state/
/// We can use a default item count and IF we need to change it, we can.
class LoadingListView extends StatelessWidget {
  final int defaultItemCount;
  final Widget child;

  final bool useListTile;

  /// For useListTile only
  final bool showSubtitle;
  final bool showLeading;
  final bool showTrailing;

  const LoadingListView(
      {super.key,
      required this.child,
      this.defaultItemCount = 4,
      this.useListTile = false,
      this.showTrailing = true,
      this.showLeading = true,
      this.showSubtitle = false});

  const LoadingListView.useListTile(
      {super.key,
      required this.child,
      this.defaultItemCount = 4,
      this.useListTile = true,
      this.showTrailing = true,
      this.showLeading = true,
      this.showSubtitle = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: defaultItemCount,
      itemBuilder: (BuildContext context, int index) {
        return useListTile ? _listTile() : child;
      },
    );
  }

  Widget _listTile() {
    return Card(
        child: LoadingListTile(
            showSubtitle: showSubtitle,
            showLeading: showLeading,
            showTrailing: showTrailing));
  }
}
