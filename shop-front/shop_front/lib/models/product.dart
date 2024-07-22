class Product {
  final int id;
  final String name;
  final String code;
  final String imageURL;
  final double price;

  Product({required this.id,required this.name, required this.code, required this.imageURL, required this.price});

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      imageURL: json['imageURL'],
      price: json['price']
    );
  }

}


