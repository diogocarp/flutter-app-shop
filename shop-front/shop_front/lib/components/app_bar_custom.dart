import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    final currentRouteName = route?.settings.name;

    return AppBar(
      backgroundColor: Colors.amber[800],
      title: Text('App Shop'),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          if (currentRouteName == '/cart') {
            Navigator.of(context).pushNamed('/start');
          } else {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            } else {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/start', (route) => false);
            }
          }
        },
      ),
    );
  }
}
