import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() {
  runApp(MaterialApp(
    home: SecondMultipleCollectionScreen(),
  ));
}



class SecondMultipleCollectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Stream Multiple Collection Read'),
      ),
      body: StreamBuilder(
        stream: fetchDataFromFirestore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Display the fetched data
            List<String>? data = snapshot.data;
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index]),
                );
              },
            );
          }
        },
      ),
    );
  }

  Stream<List<String>> fetchDataFromFirestore() {
    // Reference to the first collection
    CollectionReference collection1 =
    FirebaseFirestore.instance.collection('User1');

    // Reference to the second collection
    CollectionReference collection2 =
    FirebaseFirestore.instance.collection('User2');

    // Combine the streams
    Stream<List<String>> combinedStream =
    StreamGroup.merge([collection1.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => 'User 1: ${doc['Name']}')
          .toList();
    }), collection2.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => 'User 2: ${doc['Name']}')
          .toList();
    })]);

    return combinedStream;
  }
}
