import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';


class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  addtasktofirebase() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    
    if (user != null) {
      String uid = user.uid;
      var time = DateTime.now();
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(uid)
          .collection('mytasks')
          .doc(time.toString())
          .set({
        'title': titleController.text,
        'description': descriptionController.text,
        'time': time.toString(),
        'timestamp':time
      });
      Fluttertoast.showToast(msg: 'Data Added');
    } else {
      Fluttertoast.showToast(msg: 'User not authenticated');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('New Task'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(children: [
            Container(child: 
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Enter Title",
                labelStyle: GoogleFonts.roboto(fontSize: 16,color: const Color.fromARGB(255, 42, 35, 60)),
                border: OutlineInputBorder(borderRadius:BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.amber)),
              ),
            ),),
            SizedBox(height: 20),
            Container(child: 
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: "Enter Description",
                labelStyle: GoogleFonts.roboto(fontSize: 16,color: const Color.fromARGB(255, 42, 35, 60)),
                border: OutlineInputBorder(borderRadius:BorderRadius.circular(8)),
              ),
            ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState>states){
                    if (states.contains(MaterialState.pressed))
                    return Colors.deepPurpleAccent.shade100;
                  return Colors.deepPurpleAccent;
                  }
                  ),
                  ),
              onPressed: () {
                addtasktofirebase();
                Navigator.pop(context);
              }, 
                child: Text('Add Task',style: GoogleFonts.roboto(fontSize: 18),),
                ),
                ),
          ],
          ),
        ),
      ),
    );
  }
}
