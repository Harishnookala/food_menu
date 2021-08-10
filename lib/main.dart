import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ViewModel/apicalls.dart';
import 'model/product.dart';
import 'package:collection/collection.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Food Menu'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(12.3),
        child: ListView(
          children: <Widget>[

            FutureBuilder(
              future: Api.load_product(context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List items = snapshot.data;
                  List<Widget>children=[];
                  items.sort((a, b) => a["category"].compareTo(b["category"]));
                  String category = null;
                  items.forEach((element) {
                    if(element["category"] != category){
                      children.add(Container(
                          child: Text(element["category"], style: TextStyle(fontWeight: FontWeight.bold),)));
                      children.add(Container(
                        margin: EdgeInsets.only(top: 1.6,),
                        height: 2, color: Colors.black,));
                      category = element["category"];
                    }
                    children.add(Container(
                      margin: EdgeInsets.all(13.3),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text("productName : " + element["productName"]),
                            Text("price : " +element["price"].toString())
                          ],
                        ),
                      ),
                    ));
                  });
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  );

                } else if (snapshot.hasError) {
                  return Text("Error");
                }
                return Text("---Loading---");
              },
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
