import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/shared/utils/resources/resources.dart';
import 'package:egov/shared/widgets/header_texts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EGOvButtonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EGOvButtonAppBar({
    Key? key,
    this.title = '',
    this.hasBackHome = false,
    this.centerTile,
    this.actions,
    this.titleWidget,
  }) : super(key: key);
  final String? title;
  final bool? hasBackHome, centerTile;
  final List<Widget>? actions;
  final Widget? titleWidget;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return AppBar(
        centerTitle: centerTile ?? true,
        backgroundColor: themeProvider.themeMode().kBackgroundColor,
        automaticallyImplyLeading: hasBackHome!,
        actions: actions,
        title: titleWidget ??
            HeaderTexts(
              title: title!,
            ));
  }

  @override
  Size get preferredSize => Size.fromHeight((buttonHeight));
}
