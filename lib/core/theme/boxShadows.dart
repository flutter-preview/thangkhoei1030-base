import 'package:flutter/material.dart';

class BoxShadowsConst {
  static const List<BoxShadow> shadowCard = [
    // BoxShadow(
    //   color: Color.fromRGBO(98, 0, 238, 0.2),
    //   spreadRadius: 0.01,
    //   blurRadius: 1,
    //   offset: Offset(2, 15),
    // ),
    BoxShadow(
        color: Colors.white,
        spreadRadius: 0.01,
        blurRadius: 12,
        offset: Offset(5, 5)),
    BoxShadow(
      color: Color.fromRGBO(98, 0, 238, 0.2),
      spreadRadius: 0.01,
      blurRadius: 8,
      offset: Offset(5, 5),
    ),

    // BoxShadow(
    //     color: const Color.fromRGBO(98, 0, 238, 0.2),
    //     spreadRadius: 0.01,
    //     blurRadius: 15,
    //     offset: Offset(4, 2)),
    // BoxShadow(
    //     color: const Color.fromRGBO(98, 0, 238, 0.2),
    //     spreadRadius: 0.01,
    //     blurRadius: 15,
    //     offset: Offset(4, 2)),
    // BoxShadow(
    //     color: const Color(0x54000000),
    //     spreadRadius: spreadRadius,
    //     blurRadius: blurRadius,
    //     offset: Offset(-21, 0)),
    // BoxShadow(
    //     color: const Color(0x54000000),
    //     spreadRadius: spreadRadius,
    //     blurRadius: blurRadius,
    //     offset: Offset(-12, 0)),
  ];
  static const List<Shadow> shadowText = [
    Shadow(offset: Offset(2, 2), blurRadius: 3.0, color: Colors.white),
    Shadow(
      offset: Offset(2, 2),
      blurRadius: 8.0,
      color: Color.fromARGB(125, 0, 0, 255),
    )
  ];
}
