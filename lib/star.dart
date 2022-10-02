import 'package:flutter/material.dart';

class Star extends StatelessWidget {
  const Star({Key? key}) : super(key: key);
  final String _imageUrl = "https://www.wallpaperuse.com/wallp/9-93883_m.jpg";

  @override
  Widget build(BuildContext context) {
    print("STAR BUILD");
    return Container(
      child: Center(
        child: Image(
          image: NetworkImage(_imageUrl),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
