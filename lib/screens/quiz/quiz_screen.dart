// Developed by Eng Mouaz M AlShahmeh
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizq_flutter/controllers/question_controller.dart';

import 'components/body.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionController controller = Get.put(QuestionController());
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: const Body(),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.nextQuestion,
          child: const Text("Skip"),
        ),
      ),
    );
  }
}
