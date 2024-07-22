import 'package:flutter/material.dart';
import 'package:shop_front/components/app_bar_custom.dart';
import 'package:shop_front/config/app_controller.dart';
import 'package:shop_front/components/app_bottom_tab_custom.dart';

class ConfPage extends StatefulWidget {
  const ConfPage({super.key});

  @override
  State<ConfPage> createState() => _ConfPageState();
}

class _ConfPageState extends State<ConfPage> {
  final grey = Colors.grey[300];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Center(
        child: ListView(
          children: [
            Text(
              textAlign: TextAlign.center,
              'Configuração',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Column(
              children: [
                Container(
                  height: 70,
                  width: 320,
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Habilitar Modo Escuro',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Spacer(),
                      CustomSwitch(),
                    ],
                  ),
                ),
                Container(
                  width: 320,
                  margin: EdgeInsets.all(10),
                  height: 70,
                  child: Row(
                    children: [
                      GestureDetector(
                        child: Text(
                          'Login Administrador',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        onTap: () => Navigator.of(context).pushNamed('/login'),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                      )
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  margin: EdgeInsets.all(10),
                ),
                Container(
                  height: 70,
                  margin: EdgeInsets.all(10),
                ),
                Container(
                  height: 70,
                  margin: EdgeInsets.all(10),
                ),
                Container(
                  height: 70,
                  margin: EdgeInsets.all(10),
                ),
                Container(
                  height: 70,
                  margin: EdgeInsets.all(10),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomTabCustom(items: [
        BottomNavigationBarItem(
          label: 'Carrinho',
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Configurações',
          icon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
        )
      ]),
    );
  }
}

class CustomSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: Colors.amber[800],
      value: AppController.instance.isDarkTheme,
      onChanged: (value) {
        AppController.instance.changeTheme();
      },
    );
  }
}
