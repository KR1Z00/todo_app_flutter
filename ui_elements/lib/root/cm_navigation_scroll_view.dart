import 'package:flutter/material.dart';
import 'package:ui_elements/root/cm_logo_app_bar_leading.dart';
import 'package:ui_elements/theme/theme_extensions.dart';

enum CMNavigationAppBarType { small, medium }

class CMNavigationScrollView extends StatefulWidget {
  final String title;
  final CMNavigationAppBarType appBarType;
  final bool centerAppBarTitle;
  final Widget? appBarLeading;
  final double? appBarLeadingWidth;
  final List<Widget> appBarActions;
  final ScrollController? scrollController;
  final Color? overscrollColor;
  final Widget childSliver;

  const CMNavigationScrollView({
    super.key,
    required this.title,
    this.appBarType = CMNavigationAppBarType.medium,
    this.centerAppBarTitle = false,
    this.appBarLeading,
    this.appBarLeadingWidth = CMLogoAppBarLeading.requiredLeadingWidth,
    this.appBarActions = const [],
    this.scrollController,
    this.overscrollColor,
    required this.childSliver,
  });

  @override
  State<CMNavigationScrollView> createState() => _CMNavigationScrollViewState();
}

class _CMNavigationScrollViewState extends State<CMNavigationScrollView> {
  double _overscrollHeight = 0;
  bool get _showOverscrollFill => _overscrollHeight != 0;

  _CMNavigationScrollViewState();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Overscroll fill colour, if necessary
        if (widget.overscrollColor != null)
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: _overscrollHeight,
                  child: Opacity(
                    opacity: _showOverscrollFill ? 1 : 0,
                    child: ColoredBox(
                      color: widget.overscrollColor ?? Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        // Scroll view
        Positioned.fill(
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              if (widget.overscrollColor == null) return true;
              if (notification is ScrollUpdateNotification) {
                if (notification.metrics.pixels >=
                    notification.metrics.maxScrollExtent) {
                  final overscroll =
                      notification.metrics.pixels -
                      notification.metrics.maxScrollExtent;
                  if (_overscrollHeight != overscroll) {
                    setState(() {
                      _overscrollHeight = overscroll;
                    });
                  }
                } else if (notification.metrics.pixels <
                    notification.metrics.maxScrollExtent) {
                  if (_overscrollHeight != 0) {
                    setState(() {
                      _overscrollHeight = 0;
                    });
                  }
                }
              }
              return false;
            },
            child: CustomScrollView(
              controller: widget.scrollController,
              slivers: [
                switch (widget.appBarType) {
                  CMNavigationAppBarType.small => SliverAppBar(
                    title: Text(widget.title),
                    centerTitle: widget.centerAppBarTitle,
                    leading: widget.appBarLeading,
                    leadingWidth: widget.appBarLeadingWidth,
                    actions: widget.appBarActions,
                    pinned: true,
                    surfaceTintColor: context.colorScheme().surfaceContainerLow,
                    backgroundColor: context.colorScheme().surfaceContainerLow,
                  ),
                  CMNavigationAppBarType.medium => SliverAppBar.medium(
                    title: Text(widget.title),
                    centerTitle: widget.centerAppBarTitle,
                    leading: widget.appBarLeading,
                    leadingWidth: widget.appBarLeadingWidth,
                    actions: widget.appBarActions,
                    pinned: true,
                    surfaceTintColor: context.colorScheme().surfaceContainerLow,
                    backgroundColor: context.colorScheme().surfaceContainerLow,
                  ),
                },
                widget.childSliver,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
