import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:project_two/components.dart';

class DetailPage extends StatefulWidget {
  final DocumentSnapshot post;
  final DocumentReference reference;
  final bool isChecked;
  final bool isStarred;

  DetailPage({this.post, this.reference, this.isChecked, this.isStarred});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var firestore = FirebaseFirestore.instance;
    String name = widget.post.data()["name"];
    String location = widget.post.data()["location"];
    String number = widget.post.data()["number"];
    String size = widget.post.data()["size"];
    String quantity = widget.post.data()["quantity"];
    String dateOne = widget.post.data()["dateOne"];
    String dateTwo = widget.post.data()["dateTwo"];
    String orderTime = widget.post.data()["ordered at"];

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                      child: Icon(Icons.check, color: Colors.black54),
                    ),
                    Text(widget.isChecked ? 'Uncheck' : 'Check')
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                      child: Icon(Icons.star, color: Colors.black54),
                    ),
                    Text(widget.isStarred ? 'Unstar' : 'Star')
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                      child: Icon(Icons.delete, color: Colors.black54),
                    ),
                    Text('Delete')
                  ],
                ),
              ),
            ],
            onSelected: (value) async{
              if (value == 1) {
                firestore.runTransaction((transaction) async {
                  await transaction.update(widget.reference, {
                    'checked' : !widget.isChecked,
                  });
                }).catchError((onError){print(onError.toString());});
              } else if (value == 2) {
                firestore.runTransaction((transaction) async {
                  await transaction.update(widget.reference, {
                    'starred' : !widget.isStarred,
                  });
                }).catchError((onError){print(onError.toString());});
              } else{
                return showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Delete?'),
                        content: Text('Delete $name\'s order?'),
                        actions: [
                          FlatButton(
                            child: Text('No'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            child: Text('Yes'),
                            onPressed: () async {
                              await firestore
                                  .runTransaction((transaction) async {
                                transaction.delete(widget.reference);
                              });
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Flushbar(
                                title: "Deleted!",
                                message: "The order has been deleted",
                                animationDuration: Duration(seconds: 3),
                                duration: Duration(seconds: 3),
                              ).show(context);
                            },
                          )
                        ],
                      );
                    });
              }
            },
          ),
        ],
      ),
      body: Container(
        child: Card(
          child: ListTile(
            title: Text(name,
                style: TextStyle(
                  fontFamily: 'Alegreya',
                  fontSize: 30,
                )),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hostel: $location", style: kTextStyle),
                SizedBox(height: 10),
                SelectableText("Phone Number: $number", style: kTextStyle),
                SizedBox(height: 10),
                SelectableText("Size: $size", style: kTextStyle),
                SizedBox(height: 10),
                SelectableText("Quantity: $quantity", style: kTextStyle),
                SizedBox(height: 10),
                Text(
                    "Time of Availability: \nFrom \n" +
                        (dateOne == ("") ? "No Date Provided" : dateOne == null ? "No date Provided" : dateOne) +
                        "\nTo \n" +
                        (dateTwo == "" ? "No Date Provided" : dateTwo == null ? "No date Provided" : dateTwo),
                    style: kTextStyle),
                SizedBox(height: 10),
                SelectableText("Ordered at: $orderTime", style: kTextStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
