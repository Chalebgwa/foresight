import 'package:flutter/material.dart';

class ExchangeTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.pink,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        //color: Colors.green,
        child: ExpansionTile(
          title: Text("Kenny Ax"),
          backgroundColor: Colors.white,
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/queen.png"),
          ),
          children: <Widget>[
            Image(
              image: AssetImage("assets/1.jpg"),
            ),
            Text("Golden arm thing thats way too expensive"),
            Text(
              "BWP200.00",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
