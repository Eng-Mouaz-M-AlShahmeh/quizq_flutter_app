// Developed by Eng Mouaz M AlShahmeh
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizq_flutter/controllers/question_controller.dart';
import 'package:quizq_flutter/models/question.dart';

import '../../../constants.dart';
import 'option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    required this.question,
  }) : super(key: key);

  final Question? question;

  @override
  Widget build(BuildContext context) {
    QuestionController controller = Get.put(QuestionController());
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.5,
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            question!.question!,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: kBlackColor),
          ),
          const SizedBox(height: kDefaultPadding / 2),
          Expanded(
            child: Column(
              children: [
                ...List.generate(
                  question!.options!.length,
                  (index) => Expanded(
                    child: Option(
                      index: index,
                      text: question!.options![index],
                      press: () => controller.checkAns(question!, index),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
