
class Product{
  int productID;
  String productName;
  String category;
  int  price;

  Product({this.productID,this.productName,this.category,this.price});

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
        productID: json['productID'],
        productName: json['productName'],
        category: json['category'],
        price: json['price']);
  }
}