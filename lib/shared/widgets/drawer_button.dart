import 'package:egov/shared/utils/resources/resources.dart';
import 'package:flutter/material.dart';

class RiderDrawerButton extends StatelessWidget {
  const RiderDrawerButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => IconButton(
        icon: Icon(
          Icons.menu,
          color: primaryColor,
        ),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
    );
  }
}
