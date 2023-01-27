import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/shared/utils/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderTexts extends StatelessWidget {
  const HeaderTexts({
    Key? key,
    required this.title,
    this.description,
    this.subtitle,
    this.richText = false,
  }) : super(key: key);
  final String title;
  final String? description;
  final String? subtitle;
  final bool? richText;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HSpace((verticalPadding)),
        richText!
            ? SizedBox(
                width: MediaQuery.of(context).size.width / 1.4,
                child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        text: '$title ',
                        style: themeProvider.textTheme().bodyText2,
                        children: [
                          TextSpan(
                            text: '$subtitle',
                            style: themeProvider.textTheme().headline3,
                          ),
                        ])),
              )
            : Text(
                title,
                style: themeProvider.textTheme().headline1,
              ),
        HSpace((smallVerticalPadding) / 2),
        if (description != null)
          Padding(
            padding: EdgeInsets.only(
              right: (padding),
            ),
            child: Text(
              description!,
              textAlign: TextAlign.start,
              style: themeProvider.textTheme().bodyText1?.copyWith(
                    fontSize: (textFontSize * 0.9),
                  ),
            ),
          ),
        HSpace(
          (padding),
        ),
      ],
    );
  }
}
