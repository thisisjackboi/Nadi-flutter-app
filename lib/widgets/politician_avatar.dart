import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PoliticianAvatar extends StatelessWidget {
  final double size;

  const PoliticianAvatar({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        'assets/politician.svg',
        width: size,
        height: size,
      ),
    );
  }
}
