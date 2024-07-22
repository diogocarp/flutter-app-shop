import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop_front/models/product.dart';

class ProductListView extends StatelessWidget {
  final List<Product>? products;

  ProductListView({required this.products});

  Future<void> deleteProduct(int id, BuildContext context) async {

    final Uri url = Uri.parse('http://localhost:8081/product/deleteById?id=$id');
    try {
      final response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Sucesso!'),
            content: Text('Produto apagado!'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pushNamed('/cart');
                },
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Erro!'),
            content: Text('Falha ao retirar o produto!'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Erro ao fazer a requisição: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (products == null || products!.isEmpty) {
      return Center(child: Text('Nenhum produto disponível'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: PageScrollPhysics(),
      itemCount: products!.length,
      itemBuilder: (context, index) {
        final product = products![index];
        return Card(
          margin: EdgeInsets.all(10),
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(product.imageURL),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(product.name),
            subtitle: Text('Código: ${product.code}'),
            trailing: SizedBox(
              width: 150,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Valor: ${product.price}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.white),
                      onPressed: () {
                        deleteProduct(product.id, context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
