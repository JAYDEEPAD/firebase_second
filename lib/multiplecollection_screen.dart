import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() {
  runApp(MaterialApp(
    home: MultipleCollectionRead(),
  ));
}


class MultipleCollectionRead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiple Collection Read'),
      ),
      body: FutureBuilder(
        future: fetchDataFromFirestore(),
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
                return Row(
                  children: [
                    Text(data[index]),

                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<String>> fetchDataFromFirestore() async {
    try {
      // Reference to the first collection
      CollectionReference collection1 =
      FirebaseFirestore.instance.collection('User1');

      // Reference to the second collection
      CollectionReference collection2 =
      FirebaseFirestore.instance.collection('User2');

      // Fetch data from the first collection
      QuerySnapshot querySnapshot1 = await collection1.get();
      List<String> dataFromCollection1 = querySnapshot1.docs
          .map((doc) => 'User 1: ${doc['Name']}')
          .toList();

      // Fetch data from the second collection
      QuerySnapshot querySnapshot2 = await collection2.get();
      List<String> dataFromCollection2 = querySnapshot2.docs
          .map((doc) => 'User 2: ${doc['Name']}')
          .toList();

      print(dataFromCollection1);
      print(dataFromCollection2);



      // Combine the results
      List<String> combinedData = [];
      combinedData.addAll(dataFromCollection1);
      combinedData.addAll(dataFromCollection2);

      return combinedData;
    } catch (e) {
      // Handle errors
      print('Error fetching data: $e');
      return [];
    }
  }
}


