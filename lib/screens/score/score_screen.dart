// Developed by Eng Mouaz M AlShahmeh
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quizq_flutter/constants.dart';
import 'package:quizq_flutter/controllers/question_controller.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionController qnController = Get.put(QuestionController());
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
            Column(
              children: [
                const Spacer(flex: 3),
                Text(
                  "Score",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: kSecondaryColor),
                ),
                const Spacer(),
                Text(
                  "${qnController.numOfCorrectAns * 10}/${qnController.questions.length * 10}",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: kSecondaryColor),
                ),
                const Spacer(flex: 3),
              ],
            )
          ],
        ),
      ),
    );
  }
}
