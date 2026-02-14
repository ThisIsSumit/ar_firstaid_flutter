import 'package:ar_firstaid_flutter/models/training_progress.dart';
import 'package:flutter_riverpod/legacy.dart';

final trainingProgressProvider = StateNotifierProvider<TrainingProgressNotifier, TrainingProgress>((ref) {
  return TrainingProgressNotifier();
});


class TrainingProgressNotifier extends StateNotifier<TrainingProgress> {
  TrainingProgressNotifier() : super(TrainingProgress(
    overallProgress: 0.35,
    currentModule: 4,
    moduleProgress: {
      1: ModuleProgress(isCompleted: true, quizScore: 95, completedAt: DateTime.now().subtract(const Duration(days: 10))),
      2: ModuleProgress(isCompleted: true, quizScore: 92, completedAt: DateTime.now().subtract(const Duration(days: 7))),
      3: ModuleProgress(isCompleted: true, quizScore: 98, completedAt: DateTime.now().subtract(const Duration(days: 3))),
    },
  ));

  void completeModule(int moduleNumber, int score) {
    final newProgress = Map<int, ModuleProgress>.from(state.moduleProgress);
    newProgress[moduleNumber] = ModuleProgress(
      isCompleted: score >= 90,
      quizScore: score,
      completedAt: DateTime.now(),
    );

    final completedModules = newProgress.values.where((p) => p.isCompleted).length;
    final overallProgress = completedModules / state.totalModules;
    final nextModule = score >= 90 ? moduleNumber + 1 : moduleNumber;

    state = state.copyWith(
      moduleProgress: newProgress,
      overallProgress: overallProgress,
      currentModule: nextModule,
    );
  }
}