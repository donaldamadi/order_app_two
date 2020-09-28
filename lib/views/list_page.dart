import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flushbar/flushbar.dart';
import 'package:project_two/views/detail_page.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future _data;
  Future getOrders() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("orders")
        .orderBy("ordered at", descending: true)
        .getDocuments();
    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(
                  post: post,
                )));
  }

  @override
  void initState() {
    super.initState();
    _data = getOrders();
  }

  @override
  Widget build(BuildContext context) {
    var firestore = Firestore.instance;
    return Container(
      child: FutureBuilder(
          future: _data,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.cyan,
                  strokeWidth: 5,
                ),
              );
            } else {
              return ListView.builder(
                  itemCount:
                      snapshot.data.length == null ? 0 : snapshot.data.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      leading: Icon(Icons.person),
                      title: Text(snapshot.data[index].data["name"] ??
                          "There is an error somewhere"),
                      subtitle: Text(snapshot.data[index].data["ordered at"]),
                      trailing: IconButton(
                        tooltip: 'Delete',
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          return showDialog<void>(
                              context: context,
                              barrierDismissible: false, //user must tap button
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Delete?'),
                                  content: Text("Delete " +
                                      snapshot.data[index].data["name"] +
                                      "'s order?"),
                                  actions: [
                                    FlatButton(
                                      child: Text('No'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                      child: Text('Yes'),
                                      onPressed: () async {
                                        await firestore.runTransaction(
                                            (Transaction myTransaction) async {
                                          await myTransaction.delete(
                                              snapshot.data[index].reference);
                                        });
                                        Navigator.of(context).pop();
                                        Flushbar(
                                          title: "Deleted!",
                                          message: "The order has been deleted",
                                          duration: Duration(seconds: 3),
                                        ).show(context);
                                        setState(() {
                                          Navigator.of(context).pushNamedAndRemoveUntil('/screen2', (Route<dynamic> route) => false);
                                        });
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                      ),
                      onTap: () => navigateToDetail(snapshot.data[index]),
                    );
                  });
            }
          }),
    );
  }
}
