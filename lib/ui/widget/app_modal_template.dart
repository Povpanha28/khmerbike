import 'package:flutter/material.dart';
import 'package:khmerbike/ui/theme/app_theme.dart';

class AppModalHeader extends StatelessWidget {
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final Widget child;

  const AppModalHeader({
    super.key,
    required this.backgroundColor,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: padding,
      child: child,
    );
  }
}

class AppModalFrame extends StatelessWidget {
  final Widget header;
  final Widget body;
  final bool showDragHandle;
  final bool expandBody;
  final bool scrollableBody;
  final ScrollController? scrollController;
  final EdgeInsetsGeometry bodyPadding;
  final BorderRadiusGeometry bodyBorderRadius;

  const AppModalFrame({
    super.key,
    required this.header,
    required this.body,
    this.showDragHandle = true,
    this.expandBody = true,
    this.scrollableBody = false,
    this.scrollController,
    this.bodyPadding = const EdgeInsets.fromLTRB(28, 24, 28, 36),
    this.bodyBorderRadius = const BorderRadius.vertical(
      top: Radius.circular(28),
    ),
  });

  Widget _buildBody() {
    Widget content = body;

    if (scrollableBody) {
      content = SingleChildScrollView(
        controller: scrollController,
        child: content,
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: bodyBorderRadius,
      ),
      padding: bodyPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showDragHandle)
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          content,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: expandBody ? MainAxisSize.max : MainAxisSize.min,
      children: [
        header,
        if (expandBody) Expanded(child: _buildBody()) else _buildBody(),
      ],
    );
  }
}
