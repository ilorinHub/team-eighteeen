import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/shared/utils/resources/resources.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
    required this.themeProvider,
  }) : super(key: key);
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: (horizontalPadding),
        top: (smallVerticalPadding) * 0.1,
        bottom: (smallVerticalPadding) * 0.1,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          (buttonBorderRadius),
        ),
        color: themeProvider.themeMode().kDarkGrey?.withOpacity(0.2),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: themeProvider.isLightTheme
                ? const Color(0xff384E70)
                : Colors.white,
            size: (padding),
          ),
          Expanded(
              child: TextField(
            decoration: InputDecoration(
              hintText: 'Search Asset',
              hintStyle: themeProvider.textTheme().bodyText2,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          )),
        ],
      ),
    );
  }
}
