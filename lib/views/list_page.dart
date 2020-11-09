import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_two/views/detail_page.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  ScrollController _scrollController = ScrollController();


  @override

  @override
  Widget build(BuildContext context) {
    var firestore = FirebaseFirestore.instance;
    return StreamBuilder(
      stream: firestore
          .collection('orders')
          .orderBy('ordered at', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? DraggableScrollbar.semicircle(
              controller: _scrollController,
              labelConstraints: BoxConstraints.tightFor(width: 80.0, height: 30.0),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return BodyList(
                      name: snapshot.data.documents[index].data()['name'],
                      date: snapshot.data.documents[index].data()['ordered at'],
                      index: snapshot.data.documents[index],
                      reference: snapshot.data.documents[index].reference,
                      isChecked:
                          snapshot.data.documents[index].data()['checked'],
                      isStarred:
                          snapshot.data.documents[index].data()['starred'],
                    );
                  },
                ),
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}

class BodyList extends StatefulWidget {
  final String name;
  final String date;
  final DocumentReference reference;
  final DocumentSnapshot index;
  final bool isChecked;
  final bool isStarred;
  BodyList(
      {this.name,
      this.date,
      this.reference,
      this.index,
      this.isChecked,
      this.isStarred});

  @override
  _BodyListState createState() => _BodyListState();
}

class _BodyListState extends State<BodyList> {
  var firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(widget.name ?? "There is an error somewhere"),
      subtitle: Text(widget.date),
      tileColor: widget.isChecked ? Colors.green.withOpacity(0.5) : null,
      trailing: widget.isStarred ? Icon(Icons.star) : null,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(
                    post: widget.index,
                    reference: widget.reference,
                    isChecked: widget.isChecked,
                    isStarred: widget.isStarred)));
      },
    );
  }
}
