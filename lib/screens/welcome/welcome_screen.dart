// Developed by Eng Mouaz M AlShahmeh
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quizq_flutter/constants.dart';

import '../../controllers/question_controller.dart';
import '../quiz/quiz_screen.dart';

GlobalKey<FormState> formKey = GlobalKey<FormState>();

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionController controller = Get.put(QuestionController());

    controller.getQuestions();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            SvgPicture.asset(
              "assets/icons/bg.svg",
              fit: BoxFit.cover,
            ),
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(flex: 2),
                      Text(
                        "Login",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(
                                color: const Color(0xFF82FFCA),
                                fontWeight: FontWeight.bold),
                      ),
                      const Text("Let's Play Quiz,"),
                      const Spacer(),
                      TextFormField(
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xFF116757),
                          hintText: "Full Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Full Name is Required!";
                          }
                          return null;
                        },
                        onChanged: (value) => controller.updateFullName(value),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          if (!formKey.currentState!.validate()) return;
                          Get.to(const QuizScreen());
                        },
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(kDefaultPadding * 0.75),
                          decoration: const BoxDecoration(
                            gradient: kPrimaryGradient,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Text(
                            "Start Quiz",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: const Color(0xFFD5FFEF)),
                          ),
                        ),
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
