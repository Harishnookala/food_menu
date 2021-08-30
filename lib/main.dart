import 'package:flutter/material.dart';
import 'ViewModel/api_call.dart';
import 'model/product.dart';

void main() {
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      home: MyHomePage(title: 'Food Menu'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Product> menu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(15.3),
        child: ListView(
          children: <Widget>[
            FutureBuilder<List<Product>>(
              future: Request.load_product(context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Product> menu;
                  menu = snapshot.data;
                  List<Widget> children = [];
                  String category = null;
                  menu.sort((a, b) => a.category.compareTo(b.category));
                  menu.forEach((products) {
                    if (products.category != category) {
                      children.add(Container(
                          child: Text(
                            products.category,
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
                      )));
                      children.add(Container(
                        margin: EdgeInsets.only(
                          top: 1.6,
                        ),
                        height: 1.5,
                        color: Colors.green,
                      ));
                      category = products.category;
                    }

                    children.add(Container(
                      margin: EdgeInsets.all(13.3),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(products.productName,style: TextStyle(fontSize: 15),),
                            Text("\u20B9 " + products.price.toString())
                          ],
                        ),
                      ),
                    ));
                  });
                  return new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                }
                return new Center(
                  child: LinearProgressIndicator(),
                );
              },
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
