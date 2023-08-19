import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_firebase/screens/add_task.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid = '';

  @override
  void initState() {
    getUid();
    super.initState();
  }

  getUid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      setState(() {
        uid = user.uid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Today Goals"),
        actions: [
          IconButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut();

          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey.shade400,
        child: StreamBuilder(
  stream: FirebaseFirestore.instance
      .collection('tasks')
      .doc(uid)
      .collection('mytasks')
      .snapshots(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
      return Center(child: Text('No tasks available.'));
    } else {
      final docs = snapshot.data!.docs;
      return ListView.builder(
        itemCount: docs.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10)
            ),
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(docs[index]['title'],style: GoogleFonts.roboto(fontSize: 18),)),
                  ],
                ),
                Container(
                  child: IconButton(
                    icon: Icon(Icons.delete,
                    color: Colors.redAccent),
                    onPressed: () async{
                      await FirebaseFirestore.instance.collection('tasks').doc(uid).collection('mytasks').doc(docs[index]['time']).delete();
            
                    },
                  ),),
              ],
            ),
          );
        },
      );
    }
  },
),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddTask()));
        },
        backgroundColor: Color.fromARGB(255, 102, 47, 255),
        child: Icon(Icons.add),
      ),
    );
  }
}
