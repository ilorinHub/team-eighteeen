import 'package:flutter/material.dart';

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height / 1.7, size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class OnboardingFirstClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height / 8);
    path.quadraticBezierTo(
      size.width / 4,
      size.height / 4.5,
      size.width / 2,
      size.height / 4,
    );
    path.quadraticBezierTo(
      size.width - size.width / 4,
      size.height / 3.5,
      size.width,
      size.height / 3.47,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class OnboardingSecondClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height / 3.465);
    path.quadraticBezierTo(
        size.width / 4, size.height / 3.3, size.width / 2, size.height / 3.3);
    path.quadraticBezierTo(size.width - size.width / 4, size.height / 3.3,
        size.width, size.height / 3.47);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class OnboardingThirdClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height / 3.465);
    path.quadraticBezierTo(
      size.width / 4,
      size.height / 3.5,
      size.width / 2,
      size.height / 4,
    );
    path.quadraticBezierTo(
      size.width - size.width / 4,
      size.height / 4.5,
      size.width,
      size.height / 8.0,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
