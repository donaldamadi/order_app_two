import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final DocumentSnapshot post;

  DetailPage({this.post});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.data["name"]),
      ),
      body: Container(
        child: Card(
          child: ListTile(
            title: Text(widget.post.data["name"],
                    style: TextStyle(
                      fontFamily: 'Alegreya',
                      fontSize: 30,
                    )),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hostel: " + widget.post.data["location"],
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 20,
                    )),
                SizedBox(height: 10),
                SelectableText("Phone Number: " + widget.post.data["number"],
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Amiri',
                    )),
                SizedBox(height: 10),
                SelectableText("Size: " + widget.post.data["size"],
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 20,
                    )),
                SizedBox(height: 10),
                SelectableText("Quantity: " + widget.post.data["quantity"],
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 20,
                    )),
                SizedBox(height: 10),
                Text(
                    "Time of Availability: \nFrom \n" +
                        (widget.post.data["dateOne"] == ""
                            ? "No Date Provided"
                            : widget.post.data['dateOne']) +
                        "\nTo \n" +
                        (widget.post.data["dateTwo"] == ""
                            ? "No Date Provided"
                            : widget.post.data['dateTwo']),
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 20,
                    )),
                SizedBox(height: 10),
                SelectableText("Ordered at: " + widget.post.data["ordered at"],
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 20,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
