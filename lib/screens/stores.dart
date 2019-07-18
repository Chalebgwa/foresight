import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foresight/screens/test.dart';
import 'package:foresight/util.dart';
import 'package:foresight/wigets/product_details.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';

class HomePage extends StatefulWidget {
  final SimpleHiddenDrawerBloc controller;

  const HomePage({Key key, this.controller}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var imageFiles;
  bool isSearching = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _searchFocusNode.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 2,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.bars),
            onPressed: () {
              widget.controller.toggle();
            },
          )
        ],
        title: Text("Foresight"),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(
            image: AssetImage("assets/splash.png"),
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: isSearching
          ? FloatingActionButton(
              child: Icon(Icons.cancel),
              onPressed: () {},
            )
          : FloatingActionButton.extended(
              icon: Icon(FontAwesomeIcons.bars),
              label: Text("menu"),
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Test()));
              },
            ),
      body: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextStyle topMenuStyle = new TextStyle(
      fontFamily: 'Avenir next',
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.w600);

  final TextStyle buttonInfoStyle = new TextStyle(
      fontFamily: 'Avenir next',
      fontSize: 10,
      color: Colors.white,
      fontWeight: FontWeight.w600);

  get generateProducts {
    List<Product> productList = List.generate(10, (n) {
      return new Product(
          name: "product $n",
          description: "this is item $n",
          image_url: "assets/mobile/${n + 1}.jpg",
          price: 10.00);
    });
    return productList;
  }

  showUploadDialog(BuildContext context, Product product) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return ProductDetails(
            product: product,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: Container(
          color: Colors.white, child: buildListView(generateProducts[5])),
    );
  }

  ListView buildListView(Product feature) {
    return ListView(
      children: <Widget>[
        InkWell(
          onTap: () {
            showUploadDialog(context, feature);
          },
          child: Container(
            height: 430,
            //color: Colors.blue,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage(feature.image_url),
                  fit: BoxFit.fitHeight),
            ), // we can change to be backgroundimage instead
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[],
            ),
          ),
        ),
        Container(
          color: Colors.lightGreen,
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                child: Column(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.shoppingCart,
                        color: Colors.white, size: 20),
                    Text(
                      'My List',
                      style: buttonInfoStyle,
                    )
                  ],
                ),
                onPressed: () {},
              ),
              Chip(
                backgroundColor: Colors.pink,
                label: Text(
                  "BWP${feature.price}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              FlatButton(
                child: Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.info,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        showUploadDialog(context, feature);
                      },
                    ),
                    Text(
                      'Info',
                      style: buttonInfoStyle,
                    )
                  ],
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
        CircularHorizontal("LOCAL STORES"),
        SquareHorizontal("MOBILE DEVICES"),
        Banner(generateProducts[Random().nextInt(9)]),
        SquareHorizontalLarge('BRANDS', generateProducts),
      ],
    );
  }

  Widget Banner(Product product) {
    return Card(
      elevation: 5,
      child: new Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Avalable Now',
                style: topMenuStyle,
              ),
            ),
            InkWell(
              onTap: () {
                showUploadDialog(context, product);
              },
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(product.image_url),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 4, bottom: 4),
              color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Chip(
                    elevation: 20,
                    label: Text(
                      "BWP${product.price}",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton.icon(
                        color: Colors.white,
                        onPressed: () {},
                        icon: Icon(FontAwesomeIcons.shoppingCart),
                        label: Text("My List"),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget SquareHorizontalLarge(String title, List<Product> products) {
    return new Container(
      padding: EdgeInsets.only(top: 30, left: 10),
      height: 400,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: topMenuStyle),
                ]),
          ),
          Container(
            height: 350,
            child: ListView(
                padding: EdgeInsets.only(right: 6),
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: makeLargeHorizontals(products)),
          )
        ],
      ),
    );
  }

  List<Widget> makeLargeHorizontals(List<Product> products) {
    List<Container> productList = [];

    for (int i = 0; i < products.length; i++) {
      productList.add(new Container(
        margin: EdgeInsets.only(right: 10, top: 10),
        width: 300,
        decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage(products[i].image_url),
              fit: BoxFit.fitHeight),
        ),
      ));
    }
    return productList;
  }

  Widget CircularHorizontal(String title) {
    return new Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      height: 120,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: topMenuStyle),
                ]),
          ),
          Container(
            height: 100,
            child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(3),
                controller: ScrollController(keepScrollOffset: true),
                scrollDirection: Axis.horizontal,
                //shrinkWrap: true,
                children: makeContainers()),
          )
        ],
      ),
    );
  }

  Widget SquareHorizontal(String title) {
    return new Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      height: 220,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: topMenuStyle),
                ]),
          ),
          Container(
            height: 200,
            child: ListView(
                padding: EdgeInsets.all(3),
                scrollDirection: Axis.horizontal,
                //shrinkWrap: true,
                children: makeHorizontalSquare()),
          )
        ],
      ),
    );
  }

  List<Widget> makeContainers() {
    List<Widget> productList = [];
    int counter = 0;
    for (int i = 0; i < 6; i++) {
      counter++;
      productList.add(
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: CircleAvatar(
            radius: 30,
            backgroundImage:
                AssetImage("assets/" + counter.toString() + ".jpg"),
          ),
        ),
      );
      if (counter == 12) {
        counter = 0;
      }
    }
    return productList;
  }

  List<Widget> makeHorizontalSquare() {
    List<Container> productList = [];
    int counter = 0;
    for (int i = 1; i < 6; i++) {
      counter++;
      productList.add(new Container(
          padding: EdgeInsets.all(2),
          height: 200,
          child: Column(
            children: <Widget>[
              Container(
                height: 140,
                width: 100,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: new AssetImage(
                          "assets/mobile/" + counter.toString() + ".jpg"),
                      fit: BoxFit.fitHeight),
                ),
              ),
              Container(
                height: 30,
                margin: EdgeInsets.all(3),
                padding: EdgeInsets.only(left: 10, right: 10),
                color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 5),
                      child: Text(
                        "BWP20.00",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Icon(Icons.info, size: 15, color: Colors.white)
                  ],
                ),
              )
            ],
          )));
      if (counter == 12) {
        counter = 0;
      }
    }
    return productList;
  }
}
