import 'package:flutter/material.dart';

class BottomTabCustom extends StatefulWidget {
  final List<BottomNavigationBarItem> items;

  BottomTabCustom({required this.items});

  @override
  State<BottomTabCustom> createState() => _BottomTabCustomState();
}

class _BottomTabCustomState extends State<BottomTabCustom> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.amber[800],
      items: widget.items,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.of(context).pushNamed('/cart');
            break;
          case 1:
            Navigator.of(context).pushNamed('/conf');
            break;
        }
      },
    );
  }
}
