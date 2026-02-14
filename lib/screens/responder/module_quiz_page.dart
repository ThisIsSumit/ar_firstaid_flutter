import 'package:ar_firstaid_flutter/models/training_module.dart';
import 'package:ar_firstaid_flutter/core/providers/training_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ModuleQuizPage extends ConsumerStatefulWidget {
  final TrainingModule module;
  final int moduleNumber;

  const ModuleQuizPage({
    super.key,
    required this.module,
    required this.moduleNumber,
  });

  @override
  ConsumerState<ModuleQuizPage> createState() => _ModuleQuizPageState();
}

class _ModuleQuizPageState extends ConsumerState<ModuleQuizPage> {
  int _currentQuestionIndex = 0;
  final Map<int, int> _selectedAnswers = {};
  bool _showExplanation = false;
  bool _quizCompleted = false;
  int _score = 0;

  void _selectAnswer(int answerIndex) {
    if (_showExplanation) return;

    setState(() {
      _selectedAnswers[_currentQuestionIndex] = answerIndex;
      _showExplanation = true;
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.module.quiz.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _showExplanation = false;
      });
    } else {
      _completeQuiz();
    }
  }

  void _completeQuiz() {
    int correctAnswers = 0;
    for (int i = 0; i < widget.module.quiz.length; i++) {
      if (_selectedAnswers[i] == widget.module.quiz[i].correctAnswer) {
        correctAnswers++;
      }
    }

    setState(() {
      _score = ((correctAnswers / widget.module.quiz.length) * 100).round();
      _quizCompleted = true;
    });

    // Update progress in provider
    ref
        .read(trainingProgressProvider.notifier)
        .completeModule(widget.moduleNumber, _score);
  }

  @override
  Widget build(BuildContext context) {
    if (_quizCompleted) {
      return _buildResultsScreen();
    }

    final question = widget.module.quiz[_currentQuestionIndex];
    final selectedAnswer = _selectedAnswers[_currentQuestionIndex];
    final isCorrect = selectedAnswer == question.correctAnswer;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0E0E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => _showExitConfirmation(),
        ),
        title: Text(
          'Module ${widget.moduleNumber} Quiz',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          // Progress Indicator
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question ${_currentQuestionIndex + 1} of ${widget.module.quiz.length}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${((_currentQuestionIndex + 1) / widget.module.quiz.length * 100).toInt()}%',
                      style: TextStyle(
                        color: widget.module.color,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value:
                        (_currentQuestionIndex + 1) / widget.module.quiz.length,
                    minHeight: 8,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      widget.module.color,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Question Card
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A24),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          question.question,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: -0.1, end: 0),

                  const SizedBox(height: 24),

                  // Answer Options
                  ...question.options.asMap().entries.map((entry) {
                    final index = entry.key;
                    final option = entry.value;
                    final isSelected = selectedAnswer == index;
                    final isCorrectAnswer = index == question.correctAnswer;

                    Color? borderColor;
                    Color? backgroundColor;

                    if (_showExplanation) {
                      if (isCorrectAnswer) {
                        borderColor = const Color(0xFF22C55E);
                        backgroundColor = const Color(
                          0xFF22C55E,
                        ).withOpacity(0.1);
                      } else if (isSelected) {
                        borderColor = const Color(0xFFEF4444);
                        backgroundColor = const Color(
                          0xFFEF4444,
                        ).withOpacity(0.1);
                      }
                    } else if (isSelected) {
                      borderColor = widget.module.color;
                      backgroundColor = widget.module.color.withOpacity(0.1);
                    }

                    return _buildAnswerOption(
                      option,
                      index,
                      isSelected: isSelected,
                      borderColor: borderColor,
                      backgroundColor: backgroundColor,
                      showIcon: _showExplanation,
                      isCorrect: isCorrectAnswer,
                    ).animate().fadeIn(
                      delay: Duration(milliseconds: 100 * index),
                      duration: 400.ms,
                    );
                  }).toList(),

                  // Explanation
                  if (_showExplanation) ...[
                    const SizedBox(height: 24),
                    Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: isCorrect
                                ? const Color(0xFF22C55E).withOpacity(0.1)
                                : const Color(0xFFEF4444).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isCorrect
                                  ? const Color(0xFF22C55E)
                                  : const Color(0xFFEF4444),
                              width: 2,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    isCorrect
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    color: isCorrect
                                        ? const Color(0xFF22C55E)
                                        : const Color(0xFFEF4444),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    isCorrect ? 'Correct!' : 'Incorrect',
                                    style: TextStyle(
                                      color: isCorrect
                                          ? const Color(0xFF22C55E)
                                          : const Color(0xFFEF4444),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                question.explanation,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 400.ms)
                        .slideY(begin: 0.1, end: 0),
                  ],

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          // Next Button
          if (_showExplanation)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF0F0E0E),
                border: Border(
                  top: BorderSide(color: Colors.white.withOpacity(0.1)),
                ),
              ),
              child: SafeArea(
                child: ElevatedButton(
                  onPressed: _nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.module.color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: const Size(double.infinity, 0),
                  ),
                  child: Text(
                    _currentQuestionIndex < widget.module.quiz.length - 1
                        ? 'Next Question'
                        : 'Complete Quiz',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),
        ],
      ),
    );
  }

  Widget _buildAnswerOption(
    String text,
    int index, {
    required bool isSelected,
    Color? borderColor,
    Color? backgroundColor,
    bool showIcon = false,
    bool isCorrect = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _selectAnswer(index),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: backgroundColor ?? const Color(0xFF1A1A24),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: borderColor ?? Colors.white.withOpacity(0.1),
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    String.fromCharCode(65 + index), // A, B, C, D
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (showIcon)
                Icon(
                  isCorrect
                      ? Icons.check_circle
                      : (isSelected ? Icons.cancel : null),
                  color: isCorrect
                      ? const Color(0xFF22C55E)
                      : const Color(0xFFEF4444),
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsScreen() {
    final passed = _score >= 90;
    final totalQuestions = widget.module.quiz.length;
    final correctAnswers = ((_score / 100) * totalQuestions).round();

    return Scaffold(
      backgroundColor: const Color(0xFF0F0E0E),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 40),

                    // Score Circle
                    Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: passed
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xFF22C55E),
                                      Color(0xFF16A34A),
                                    ],
                                  )
                                : const LinearGradient(
                                    colors: [
                                      Color(0xFFEF4444),
                                      Color(0xFFDC2626),
                                    ],
                                  ),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    (passed
                                            ? const Color(0xFF22C55E)
                                            : const Color(0xFFEF4444))
                                        .withOpacity(0.3),
                                blurRadius: 30,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                passed ? Icons.emoji_events : Icons.refresh,
                                color: Colors.white,
                                size: 48,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '$_score%',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 48,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        )
                        .animate()
                        .scale(duration: 600.ms, curve: Curves.elasticOut)
                        .fadeIn(),

                    const SizedBox(height: 32),

                    // Result Message
                    Text(
                      passed ? 'Congratulations!' : 'Keep Trying!',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().fadeIn(delay: 300.ms),

                    const SizedBox(height: 12),

                    Text(
                      passed
                          ? 'You\'ve passed Module ${widget.moduleNumber}!'
                          : 'You need 90% or higher to pass',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(delay: 400.ms),

                    const SizedBox(height: 40),

                    // Stats Cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            'Correct',
                            '$correctAnswers',
                            Icons.check_circle,
                            const Color(0xFF22C55E),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildStatCard(
                            'Questions',
                            '$totalQuestions',
                            Icons.quiz,
                            const Color(0xFF3B82F6),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Message
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A24),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            passed ? Icons.lock_open : Icons.lock,
                            color: passed
                                ? const Color(0xFF22C55E)
                                : const Color(0xFFEF4444),
                            size: 32,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            passed
                                ? 'Module ${widget.moduleNumber + 1} is now unlocked!'
                                : 'Review the material and try again',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            passed
                                ? 'Continue your journey to become an Advanced Responder.'
                                : 'Study the explanations and retake the quiz when ready.',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 500.ms),
                  ],
                ),
              ),
            ),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  if (passed)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF22C55E),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        minimumSize: const Size(double.infinity, 0),
                      ),
                      child: const Text(
                        'Continue to Next Module',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _currentQuestionIndex = 0;
                          _selectedAnswers.clear();
                          _showExplanation = false;
                          _quizCompleted = false;
                          _score = 0;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEF4444),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        minimumSize: const Size(double.infinity, 0),
                      ),
                      child: const Text(
                        'Retake Quiz',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Review Module Content',
                      style: TextStyle(color: Color(0xFF3B82F6), fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A24),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 13,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms).scale(begin: const Offset(0.9, 0.9));
  }

  void _showExitConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          'Exit Quiz?',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Your progress will be lost if you exit now.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close quiz
            },
            child: const Text(
              'Exit',
              style: TextStyle(color: Color(0xFFEF4444)),
            ),
          ),
        ],
      ),
    );
  }
}
