import 'package:flutter/material.dart';

class LogoAsset extends StatelessWidget {
  const LogoAsset({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = const AssetImage('assets/images/logo.png');
    Image image = Image(image: assetImage);
    return Container(
      child: image,
    );
  }
}
