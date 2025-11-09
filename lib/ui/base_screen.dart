import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:image_app/support/config/app_color.dart';
import 'package:image_app/support/config/app_theme.dart';
import 'package:image_app/ui/shared/components/my_app_bar.dart';

class BaseScreen extends StatefulWidget {
  final String? title;
  final String? title_2;

  final String? subTitle;
  final Widget body;
  final Widget? drawer;
  final Widget? endDrawer;
  final PreferredSizeWidget? appBar;

  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;
  final bool isAppBarRequired;
  final bool isBottomNavBarRequired;
  final Widget? floatingActionButton;
  final bool? automaticallyImplyLeading;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;
  final List<Widget>? headerActions;
  final Widget? titleTrailingWidget;
  final bool showIcons;
  final Color? backgroundColor;

  const BaseScreen({
    super.key,
    required this.body,
    this.titleTrailingWidget,
    this.title,
    this.subTitle,
    this.endDrawer,
    this.drawer,
    this.bottomNavigationBar,
    this.automaticallyImplyLeading,
    this.resizeToAvoidBottomInset,
    this.actions,
    this.onBackPressed,
    this.isAppBarRequired = true,
    this.floatingActionButton,
    this.appBar,
    this.isBottomNavBarRequired = false,
    this.showIcons = false,
    this.headerActions,
    this.title_2,
    this.backgroundColor,
  });

  @override
  BaseScreenState createState() => BaseScreenState();
}

class BaseScreenState extends State<BaseScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {}
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.onBackPressed == null,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }

        widget.onBackPressed?.call();
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: !isDark
              ? widget.backgroundColor ??
                  (isDark ? secondaryColor : backgroundColor)
              : (isDark ? secondaryColor : backgroundColor),
          endDrawer: widget.endDrawer,
          appBar: widget.isAppBarRequired
              ? widget.appBar ??
                  MyAppBar(
                    titleTrailingWidget: widget.titleTrailingWidget,
                    title: widget.title,
                    title_2: widget.title_2,
                    subTitle: widget.subTitle,
                    backgroundColor: widget.backgroundColor,
                    actions: widget.actions,
                    automaticallyImplyLeading: widget.automaticallyImplyLeading,
                    onBackPressed: widget.onBackPressed,
                    headerActions: widget.headerActions,
                    showIcons: widget.showIcons,
                    showDrawer:
                        widget.drawer != null || widget.endDrawer != null,
                  )
              : null,
          body: widget.body,
          bottomNavigationBar: kIsWeb
              ? null
              : widget.isBottomNavBarRequired
                  ? widget.bottomNavigationBar
                  : null,
          floatingActionButton: widget.floatingActionButton,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset ?? false,
        ),
      ),
    );
  }
}
