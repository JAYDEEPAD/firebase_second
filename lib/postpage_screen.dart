import 'package:firebase_second/Detail_screen.dart';
import 'package:firebase_second/add_post.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostsPageScreen extends StatefulWidget {
  PostsPageScreen({Key? key}) : super(key: key){
    _referencePosts=FirebaseFirestore.instance.collection('posts');
    _future=_referencePosts.get();
  }
  late CollectionReference _referencePosts;
  late Future<QuerySnapshot>_future;

  @override
  State<PostsPageScreen> createState() => _PostsPageScreenState();
}

class _PostsPageScreenState extends State<PostsPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posts'),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddPost()));
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: widget._future,
        builder: (context,snapshot){
          if(snapshot.hasError)
          {
            return Center(child: Text('Error:${snapshot.error}'));
          }

          if(snapshot.hasData)
          {
            QuerySnapshot data=snapshot.data!;
            List<QueryDocumentSnapshot> documents=data.docs;
            List<Map> items=documents.map((e) => {
              'id':e.id,
              'title':e['title']}).toList();

            return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context,index){
                  Map thisItem=items[index] as Map;
                  return ListTile(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailScreen(thisItem)));
                    },
                    title: Text(thisItem['title']),);
                });
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}


