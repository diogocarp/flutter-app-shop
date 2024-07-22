import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop_front/components/app_bar_custom.dart';
import 'package:shop_front/components/app_product_list.dart';
import 'package:shop_front/components/app_bottom_tab_custom.dart';
import 'package:shop_front/models/product.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  List<Product>? products;
  bool isLoading = false;
  String? errorMessage;

  double calculateTotalPrice() {
  if (products == null || products!.isEmpty) {
    return 0.0;
  }

  double totalPrice = 0.0;
  for (var product in products!) {
    totalPrice += product.price ?? 0.0;
  }
  return totalPrice;
}


  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

 String ticket = '';

  readQRCode() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
      '#FFFFFF',
      'Cancelar',
      false,
      ScanMode.BARCODE,
    );
    setState(() {
      ticket = code != -1 ? json.decode(code) : "Não válidado";
    });
  }

  Future<void> fetchProducts() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response =
          await http.get(Uri.parse('http://localhost:8081/product/findAll'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          products = data.map((item) => Product.fromJson(item)).toList();
        });
      } else {
        setState(() {
          errorMessage = 'Falha ao carregar os produtos!';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Erro ao fazer a requisição: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
                      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Escanear Produtos',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : errorMessage != null
                    ? Center(child: Text(errorMessage!))
                    : ProductListView(products: products),
          ),
          SizedBox(height: 10),
          TextButton(
            style: ButtonStyle(
              alignment: Alignment.bottomLeft,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ir para pagamento', style: TextStyle(fontSize: 20)),
                SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 30,
                ),
              ],
            ),
            onPressed: () {
              double totalPrice = calculateTotalPrice();
              Navigator.of(context).pushNamed('/payment', arguments: totalPrice);
            },
          ),
          SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: BottomTabCustom(
        items: [
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
          ),
        ],
      ),
    );
  }
}
