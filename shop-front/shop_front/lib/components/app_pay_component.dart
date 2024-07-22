import 'package:flutter/material.dart';
import 'package:shop_front/config/app_controller.dart';

final List<Map<String, String>> paymentMethods = [
  {
    'title': 'Cartão de Crédito',
    'image': 'https://cdn-icons-png.flaticon.com/512/71/71227.png',
    'page': 'cc'
  },
  {
    'title': 'Cartão de Débito',
    'image': 'https://cdn-icons-png.flaticon.com/512/3190/3190478.png',
    'page': 'cd'
  },
  {
    'title': 'PIX',
    'image':
        'https://raw.githubusercontent.com/thiagozs/go-pixgen/main/assets/logo-pix.png',
    'page': 'pix'
  },
];

class AppPayComponent extends StatefulWidget {
  const AppPayComponent({super.key});

  @override
  State<AppPayComponent> createState() => _AppPayComponentState();
}

class _AppPayComponentState extends State<AppPayComponent> {


  @override
  Widget build(BuildContext context) {

    final double totalPrice = ModalRoute.of(context)!.settings.arguments as double;

    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 18,
        crossAxisSpacing: 18,
        childAspectRatio: 1,
      ),
      itemCount: paymentMethods.length,
      itemBuilder: (context, index) {
        final method = paymentMethods[index];
        return Container(
          decoration: BoxDecoration(
            color: AppController.instance.isDarkTheme ? Colors.grey[800] :  Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: GestureDetector(

             onTap: () {
                  Navigator.of(context)
                      .pushNamed('/confirm-${method['page']!}', arguments: totalPrice);
                },
            child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
                Image.network(
                  method['image']!,
                  width: 60,
                  height: 40,
                ),
               
              
              SizedBox(height: 10),
              Text(
                method['title']!,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
        );
      },
    );
  }
}
