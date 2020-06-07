import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {

  CircleImage(@required this.uri);

  final String uri;

  @override
  Widget build(BuildContext context) {
    double _size = 300.0;

    return Center(
      child: new Container(
        width: _size,
        height: _size,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
            fit: BoxFit.cover,
            image: new NetworkImage(this.uri),
          ),
        ),
      ),
    );
  }
}