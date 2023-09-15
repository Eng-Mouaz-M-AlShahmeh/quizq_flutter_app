// Developed by Eng Mouaz M AlShahmeh
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quizq_flutter/models/question.dart';
import 'package:quizq_flutter/screens/score/score_screen.dart';

class QuestionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation? _animation;
  Animation? get animation => _animation;

  PageController? _pageController;
  PageController? get pageController => _pageController;

  final List<Question> _questions = [];

  List<Question> get questions => _questions;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  int? _correctAns;
  int? get correctAns => _correctAns;

  int? _selectedAns;
  int? get selectedAns => _selectedAns;

  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;

  String _fullName = "";
  String get fullName => _fullName;

  @override
  onInit() {
    _questions.clear();
    _animationController =
        AnimationController(duration: const Duration(seconds: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!)
      ..addListener(() {
        update();
      });

    _animationController?.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    super.onInit();
  }

  @override
  onClose() {
    super.onClose();
    _animationController?.dispose();
    _pageController?.dispose();
  }

  checkAns(Question question, int selectedIndex) {
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;
    if (_correctAns == _selectedAns) _numOfCorrectAns++;
    _animationController?.stop();
    update();
    Future.delayed(const Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController?.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);

      _animationController?.reset();

      _animationController?.forward().whenComplete(nextQuestion);
    } else {
      CollectionReference scores =
          FirebaseFirestore.instance.collection('scores');
      scores.add({
        'full_name': fullName,
        'score': _numOfCorrectAns * 10,
        'timestamp': DateTime.now().toString(),
      });
      // .then((value) => print("User Added"))
      // .catchError((error) => print("Failed to add user: $error"));

      Get.to(const ScoreScreen());
    }
  }

  updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }

  updateFullName(String value) {
    _fullName = value;
  }

  getQuestions() {
    List<Question> questionList = [];
    FirebaseFirestore.instance
        .collection("questions")
        .get()
        .then((querySnapshot) {
      questionList.clear();
      _questions.clear();
      questionList = querySnapshot.docs
          .map((e) => Question(
                id: e.data()['id'],
                question: e.data()['question'],
                options: (e.data()['options'] as List<dynamic>).cast<String>(),
                answer: e.data()['answer_index'],
              ))
          .toList();
      _questions.addAll(questionList);
      return;
    });
    update();
    return;
  }
}
