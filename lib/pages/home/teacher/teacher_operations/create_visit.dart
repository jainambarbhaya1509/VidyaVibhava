import 'package:flutter/material.dart';

class CreateVisit extends StatefulWidget {
  const CreateVisit({super.key});

  @override
  State<CreateVisit> createState() => _CreateVisitState();
}

class _CreateVisitState extends State<CreateVisit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Visit'),
      ),
      body: Center(
        child: Text('Create Visit'),
      ),
    );
  }
}