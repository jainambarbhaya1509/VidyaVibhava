import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CareerQuizResult extends ConsumerStatefulWidget {
  const CareerQuizResult({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CareerQuizResultState();
}

class _CareerQuizResultState extends ConsumerState<CareerQuizResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: GeneralAppText(
            text: "Career Quiz Result",
            size: 20,
            weight: FontWeight.bold,
          ),
        ),
        body: Column(
          children: [
            GeneralAppText(text: "Congratulations! You're 90% C = Creative", size: 17,)
          ],
        ));
  }
}
