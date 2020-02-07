import 'package:flutter/material.dart';
import 'package:ssbu_info/screens/character_display.dart';

Widget characterCard(dynamic data, BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.amber,
        boxShadow: <BoxShadow>[
          BoxShadow(
              blurRadius: 10,
              offset: Offset.zero,
              color: Colors.grey.withOpacity(0.5))
        ],
        borderRadius: BorderRadius.circular(15)),
    margin: EdgeInsets.all(10),
    child: FlatButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CharacterDisplay()));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.all(20),
      child: Stack(
        children: [
          new Center(
              child: new Text(
            data['series'],
            style: TextStyle(
              color: Colors.red,
            ),
          )),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(data['info']['name']),
                    Text(data['difficulty'].toString()),
                  ],
                ),
                Text("Stock Icon here"),
                Text("Custom color"),
              ])
        ],
      ),
    ),
  );
}
