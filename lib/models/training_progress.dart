class TrainingProgress {
  final int currentModule;
  final int totalModules;
  final double overallProgress;
  final Map<int, ModuleProgress> moduleProgress;

  TrainingProgress({
    this.currentModule = 1,
    this.totalModules = 12,
    this.overallProgress = 0.0,
    this.moduleProgress = const {},
  });

  TrainingProgress copyWith({
    int? currentModule,
    int? totalModules,
    double? overallProgress,
    Map<int, ModuleProgress>? moduleProgress,
  }) {
    return TrainingProgress(
      currentModule: currentModule ?? this.currentModule,
      totalModules: totalModules ?? this.totalModules,
      overallProgress: overallProgress ?? this.overallProgress,
      moduleProgress: moduleProgress ?? this.moduleProgress,
    );
  }
}
class ModuleProgress {
  final bool isCompleted;
  final int? quizScore;
  final DateTime? completedAt;

  ModuleProgress({
    this.isCompleted = false,
    this.quizScore,
    this.completedAt,
  });
}