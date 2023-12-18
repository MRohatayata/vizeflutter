import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vizeflutter/services/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FireStoreService fireStoreService = FireStoreService();

  final TextEditingController _bookController = TextEditingController();


  void openBookBox(){
    showDialog(context: context, builder: ((context) => AlertDialog(
      content: TextField(
        controller: _bookController,
      ),
      actions: [
        ElevatedButton(onPressed: (){
            
        }, child: Text("Add"))
      ],
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kitaplar")),
      floatingActionButton: FloatingActionButton(
        onPressed:openBookBox,
        child: const Icon(Icons.add)
      ),
    );
  }
}