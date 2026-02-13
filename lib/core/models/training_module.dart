// Training Module Data
import 'dart:ui';

import 'package:flutter/material.dart';

class TrainingModule {
  final int id;
  final String title;
  final String description;
  final String duration;
  final IconData icon;
  final Color color;
  final List<String> topics;
  final List<QuizQuestion> quiz;

  TrainingModule({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.icon,
    required this.color,
    required this.topics,
    required this.quiz,
  });
}
class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String explanation;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });
}