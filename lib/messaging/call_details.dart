import 'package:flutter/material.dart';

class CallDetailsPage extends StatefulWidget {
  const CallDetailsPage({Key? key}) : super(key: key);

  @override
  State<CallDetailsPage> createState() => _CallDetailsPageState();
}

class _CallDetailsPageState extends State<CallDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Call Details"),
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios, color: Colors.white,)),
      ),
      body: Center(
        child: Text("Vikas Suthar", style: TextStyle(fontSize: 32),),
      ),
    );
  }
}
