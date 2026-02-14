import 'package:ar_firstaid_flutter/models/training_module.dart';
import 'package:ar_firstaid_flutter/models/training_progress.dart';
import 'package:ar_firstaid_flutter/core/providers/training_provider.dart';
import 'package:ar_firstaid_flutter/screens/responder/module_content_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// Training modules data
final trainingModulesData = [
  TrainingModule(
    id: 1,
    title: 'Introduction to First Response',
    description: 'Learn the fundamental principles of emergency response and your role as a first responder.',
    duration: '15 min',
    icon: Icons.local_hospital,
    color: const Color(0xFFFF3B5C),
    topics: [
      'Scene Safety Assessment',
      'Personal Protection Equipment',
      'Emergency Response Chain',
      'Legal Considerations',
    ],
    quiz: [
      QuizQuestion(
        question: 'What is the FIRST step when arriving at an emergency scene?',
        options: [
          'Begin CPR immediately',
          'Assess scene safety',
          'Call for backup',
          'Check for breathing',
        ],
        correctAnswer: 1,
        explanation: 'Scene safety is always the first priority to protect yourself and others from additional harm.',
      ),
      QuizQuestion(
        question: 'Which of the following is NOT part of PPE?',
        options: [
          'Gloves',
          'Face shield',
          'Stethoscope',
          'Eye protection',
        ],
        correctAnswer: 2,
        explanation: 'While a stethoscope is medical equipment, it is not considered Personal Protective Equipment (PPE).',
      ),
      QuizQuestion(
        question: 'Good Samaritan laws are designed to:',
        options: [
          'Punish responders',
          'Protect responders acting in good faith',
          'Require everyone to respond',
          'Limit medical treatment',
        ],
        correctAnswer: 1,
        explanation: 'Good Samaritan laws protect responders who provide reasonable assistance in emergency situations.',
      ),
      QuizQuestion(
        question: 'What does the acronym ABC stand for in emergency care?',
        options: [
          'Always Be Calm',
          'Assess, Breathe, Compress',
          'Airway, Breathing, Circulation',
          'Alert, Blood, Compress',
        ],
        correctAnswer: 2,
        explanation: 'ABC stands for Airway, Breathing, and Circulation - the fundamental assessment priorities.',
      ),
      QuizQuestion(
        question: 'When should you move a victim from the scene?',
        options: [
          'Always immediately',
          'Never move the victim',
          'Only if the scene is unsafe',
          'After checking vitals',
        ],
        correctAnswer: 2,
        explanation: 'Move a victim only if the scene is unsafe or you need to provide life-saving care.',
      ),
    ],
  ),
  TrainingModule(
    id: 2,
    title: 'Adult CPR Fundamentals',
    description: 'Master the techniques of cardiopulmonary resuscitation for adult patients.',
    duration: '25 min',
    icon: Icons.favorite,
    color: Colors.red,
    topics: [
      'Recognition of Cardiac Arrest',
      'Compression Technique',
      'Rescue Breathing',
      'AED Operation',
    ],
    quiz: [
      QuizQuestion(
        question: 'What is the correct compression rate for adult CPR?',
        options: [
          '60-80 per minute',
          '100-120 per minute',
          '120-140 per minute',
          '80-100 per minute',
        ],
        correctAnswer: 1,
        explanation: 'The recommended compression rate is 100-120 compressions per minute.',
      ),
      QuizQuestion(
        question: 'How deep should chest compressions be for an adult?',
        options: [
          '1-2 inches',
          '2-2.4 inches',
          '3-4 inches',
          '1 inch',
        ],
        correctAnswer: 1,
        explanation: 'Adult chest compressions should be at least 2 inches (5 cm) but no more than 2.4 inches (6 cm) deep.',
      ),
      QuizQuestion(
        question: 'What is the compression to ventilation ratio for single-rescuer adult CPR?',
        options: [
          '15:2',
          '30:2',
          '5:1',
          '10:2',
        ],
        correctAnswer: 1,
        explanation: 'The ratio is 30 compressions to 2 rescue breaths for single-rescuer adult CPR.',
      ),
      QuizQuestion(
        question: 'When using an AED, you should:',
        options: [
          'Continue CPR during analysis',
          'Stand clear during shock delivery',
          'Remove wet clothing but not jewelry',
          'Only use on conscious patients',
        ],
        correctAnswer: 1,
        explanation: 'Always ensure no one is touching the patient during AED analysis and shock delivery.',
      ),
      QuizQuestion(
        question: 'Hand position for adult CPR compressions should be:',
        options: [
          'Upper third of sternum',
          'Lower half of sternum',
          'Left side of chest',
          'Upper abdomen',
        ],
        correctAnswer: 1,
        explanation: 'Place hands on the lower half of the sternum (center of chest between nipples).',
      ),
    ],
  ),
  TrainingModule(
    id: 3,
    title: 'Airway Management',
    description: 'Learn techniques to maintain and secure patient airways in emergency situations.',
    duration: '20 min',
    icon: Icons.air,
    color: const Color(0xFF3B82F6),
    topics: [
      'Head-Tilt Chin-Lift',
      'Jaw-Thrust Maneuver',
      'Recovery Position',
      'Choking Response',
    ],
    quiz: [
      QuizQuestion(
        question: 'The head-tilt chin-lift maneuver is used to:',
        options: [
          'Check for injuries',
          'Open the airway',
          'Stop bleeding',
          'Assess consciousness',
        ],
        correctAnswer: 1,
        explanation: 'The head-tilt chin-lift maneuver is the primary method to open an airway in an unconscious patient without suspected spinal injury.',
      ),
      QuizQuestion(
        question: 'When should you use the jaw-thrust maneuver instead of head-tilt chin-lift?',
        options: [
          'For all patients',
          'When spinal injury is suspected',
          'Only on children',
          'When patient is conscious',
        ],
        correctAnswer: 1,
        explanation: 'Use jaw-thrust when spinal injury is suspected to avoid moving the neck.',
      ),
      QuizQuestion(
        question: 'The recovery position is appropriate for:',
        options: [
          'Cardiac arrest victims',
          'Unconscious breathing patients',
          'Choking victims',
          'Patients with chest pain',
        ],
        correctAnswer: 1,
        explanation: 'Place unconscious but breathing patients in recovery position to maintain airway and prevent aspiration.',
      ),
      QuizQuestion(
        question: 'For a conscious choking adult, you should perform:',
        options: [
          'CPR immediately',
          'Back blows only',
          'Abdominal thrusts (Heimlich)',
          'Finger sweep',
        ],
        correctAnswer: 2,
        explanation: 'Perform abdominal thrusts for conscious choking adults until object is expelled or patient becomes unconscious.',
      ),
      QuizQuestion(
        question: 'Signs of inadequate breathing include:',
        options: [
          'Normal speech',
          'Gasping or difficulty breathing',
          'Pink skin color',
          'Relaxed posture',
        ],
        correctAnswer: 1,
        explanation: 'Gasping, labored breathing, and cyanosis (blue color) indicate inadequate breathing.',
      ),
    ],
  ),
  TrainingModule(
    id: 4,
    title: 'Trauma Assessment',
    description: 'Systematic approach to identifying and prioritizing injuries in trauma patients.',
    duration: '30 min',
    icon: Icons.healing,
    color: Colors.orange,
    topics: [
      'Primary Survey',
      'Secondary Survey',
      'SAMPLE History',
      'Vital Signs Assessment',
    ],
    quiz: [
      QuizQuestion(
        question: 'What does SAMPLE stand for in patient assessment?',
        options: [
          'Scene, Airway, Medical, Pain, Last meal, Events',
          'Signs, Allergies, Medications, Past history, Last meal, Events',
          'Safety, Assessment, Medications, Pain, Location, Emergency',
          'Symptoms, Airway, Medications, Pulse, Level, Events',
        ],
        correctAnswer: 1,
        explanation: 'SAMPLE: Signs/Symptoms, Allergies, Medications, Past medical history, Last oral intake, Events leading to incident.',
      ),
      QuizQuestion(
        question: 'The primary survey focuses on:',
        options: [
          'Patient history',
          'Life-threatening conditions',
          'Minor injuries',
          'Documentation',
        ],
        correctAnswer: 1,
        explanation: 'The primary survey identifies and treats immediate life-threatening conditions using ABCDE approach.',
      ),
      QuizQuestion(
        question: 'Normal adult respiratory rate is:',
        options: [
          '6-10 breaths per minute',
          '12-20 breaths per minute',
          '25-30 breaths per minute',
          '30-40 breaths per minute',
        ],
        correctAnswer: 1,
        explanation: 'Normal adult respiratory rate is 12-20 breaths per minute at rest.',
      ),
      QuizQuestion(
        question: 'Which of the following is part of the secondary survey?',
        options: [
          'Airway management',
          'Head-to-toe examination',
          'CPR',
          'Scene safety',
        ],
        correctAnswer: 1,
        explanation: 'Secondary survey includes detailed head-to-toe physical examination after life threats are addressed.',
      ),
      QuizQuestion(
        question: 'What does the "E" in ABCDE primary survey stand for?',
        options: [
          'Emergency',
          'Expose/Environment',
          'Evaluate',
          'Equipment',
        ],
        correctAnswer: 1,
        explanation: 'E stands for Expose/Environmental control - remove clothing to assess injuries while preventing hypothermia.',
      ),
    ],
  ),
  TrainingModule(
    id: 5,
    title: 'Bleeding Control',
    description: 'Techniques for controlling external and internal bleeding in emergency situations.',
    duration: '25 min',
    icon: Icons.bloodtype,
    color: const Color(0xFFDC2626),
    topics: [
      'Direct Pressure',
      'Pressure Points',
      'Tourniquet Application',
      'Shock Recognition',
    ],
    quiz: [
      QuizQuestion(
        question: 'The first step in controlling severe bleeding is:',
        options: [
          'Apply a tourniquet',
          'Apply direct pressure',
          'Elevate the limb',
          'Apply ice',
        ],
        correctAnswer: 1,
        explanation: 'Direct pressure is the first and most effective method for controlling most bleeding.',
      ),
      QuizQuestion(
        question: 'A tourniquet should be applied:',
        options: [
          'Directly over the wound',
          '2-3 inches above the wound',
          'Below the wound',
          'On the opposite limb',
        ],
        correctAnswer: 1,
        explanation: 'Apply tourniquet 2-3 inches above the bleeding site, never directly on a joint.',
      ),
      QuizQuestion(
        question: 'Signs of shock include:',
        options: [
          'Slow pulse, warm skin',
          'Rapid pulse, cool clammy skin',
          'Normal breathing, pink skin',
          'Increased appetite',
        ],
        correctAnswer: 1,
        explanation: 'Shock symptoms include rapid weak pulse, cool clammy skin, rapid breathing, and altered mental status.',
      ),
      QuizQuestion(
        question: 'When should you consider using a tourniquet?',
        options: [
          'For all bleeding',
          'Only for life-threatening limb bleeding',
          'For minor cuts',
          'Never use a tourniquet',
        ],
        correctAnswer: 1,
        explanation: 'Use tourniquets only for severe, life-threatening limb bleeding when direct pressure fails.',
      ),
      QuizQuestion(
        question: 'After applying a tourniquet, you should:',
        options: [
          'Remove it after 5 minutes',
          'Note the time of application',
          'Loosen it periodically',
          'Apply ice directly to it',
        ],
        correctAnswer: 1,
        explanation: 'Always note and record the time of tourniquet application - do not remove or loosen it.',
      ),
    ],
  ),
  // Add more modules as needed...
  TrainingModule(
    id: 6,
    title: 'Shock Management',
    description: 'Recognition and treatment of various types of shock.',
    duration: '20 min',
    icon: Icons.monitor_heart,
    color: const Color(0xFF8B5CF6),
    topics: [
      'Types of Shock',
      'Recognition Signs',
      'Treatment Protocol',
      'Position Management',
    ],
    quiz: [],
  ),
  TrainingModule(
    id: 7,
    title: 'Fracture & Splinting',
    description: 'Proper techniques for immobilizing suspected fractures.',
    duration: '25 min',
    icon: Icons.healing_outlined,
    color: const Color(0xFF06B6D4),
    topics: [
      'Fracture Assessment',
      'Splinting Principles',
      'Improvised Splints',
      'Spinal Immobilization',
    ],
    quiz: [],
  ),
  TrainingModule(
    id: 8,
    title: 'Burns & Thermal Injuries',
    description: 'Assessment and treatment of burn injuries.',
    duration: '20 min',
    icon: Icons.local_fire_department,
    color: const Color(0xFFF59E0B),
    topics: [
      'Burn Classification',
      'Rule of Nines',
      'Cooling Techniques',
      'Dressing Application',
    ],
    quiz: [],
  ),
  TrainingModule(
    id: 9,
    title: 'Medical Emergencies',
    description: 'Common medical emergencies and appropriate responses.',
    duration: '30 min',
    icon: Icons.medication,
    color: const Color(0xFF10B981),
    topics: [
      'Diabetic Emergencies',
      'Seizures',
      'Stroke Recognition',
      'Allergic Reactions',
    ],
    quiz: [],
  ),
  TrainingModule(
    id: 10,
    title: 'Environmental Emergencies',
    description: 'Heat, cold, and altitude-related emergencies.',
    duration: '20 min',
    icon: Icons.thermostat,
    color: const Color(0xFF0EA5E9),
    topics: [
      'Heat Exhaustion',
      'Hypothermia',
      'Frostbite',
      'Altitude Sickness',
    ],
    quiz: [],
  ),
  TrainingModule(
    id: 11,
    title: 'Pediatric Emergencies',
    description: 'Special considerations for treating children.',
    duration: '25 min',
    icon: Icons.child_care,
    color: const Color(0xFFEC4899),
    topics: [
      'Pediatric Assessment',
      'Child CPR',
      'Infant CPR',
      'Common Pediatric Emergencies',
    ],
    quiz: [],
  ),
  TrainingModule(
    id: 12,
    title: 'Final Assessment',
    description: 'Comprehensive evaluation of all learned skills.',
    duration: '45 min',
    icon: Icons.assignment_turned_in,
    color: const Color(0xFF6366F1),
    topics: [
      'Scenario-Based Questions',
      'Practical Skills Review',
      'Emergency Protocols',
      'Certification Preparation',
    ],
    quiz: [],
  ),
];

class TrainingDashboardPage extends ConsumerWidget {
  const TrainingDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(trainingProgressProvider);
    
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E0E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Advanced Responder Course',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white70),
            onPressed: () => _showCourseInfo(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            
            // Overall Progress Card
            _buildOverallProgressCard(progress),
            
            const SizedBox(height: 32),
            
            // Module List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'COURSE MODULES',
                style: TextStyle(
                  color: const Color(0xFFFF3B5C).withOpacity(0.8),
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            ...trainingModulesData.map((module) {
              final moduleProgress = progress.moduleProgress[module.id];
              final isCompleted = moduleProgress?.isCompleted ?? false;
              final isLocked = module.id > progress.currentModule;
              final isCurrent = module.id == progress.currentModule;
              
              return _buildModuleCard(
                context,
                ref,
                module,
                isCompleted: isCompleted,
                isLocked: isLocked,
                isCurrent: isCurrent,
                score: moduleProgress?.quizScore,
              );
            }).toList(),
            
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallProgressCard(TrainingProgress progress) {
    final completedModules = progress.moduleProgress.values.where((p) => p.isCompleted).length;
    final percentComplete = (progress.overallProgress * 100).toInt();
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3B82F6).withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Overall Progress',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Advanced Responder',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$percentComplete%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress.overallProgress,
                minHeight: 10,
                backgroundColor: Colors.white.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$completedModules of ${progress.totalModules} modules completed',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
                const Row(
                  children: [
                    Icon(Icons.timer, color: Colors.white70, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '~4h remaining',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      )
          .animate()
          .fadeIn(duration: 500.ms)
          .slideY(begin: -0.2, end: 0),
    );
  }

  Widget _buildModuleCard(
    BuildContext context,
    WidgetRef ref,
    TrainingModule module, {
    required bool isCompleted,
    required bool isLocked,
    required bool isCurrent,
    int? score,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Opacity(
        opacity: isLocked ? 0.5 : 1.0,
        child: InkWell(
          onTap: isLocked
              ? null
              : () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ModuleContentPage(
                        module: module,
                        moduleNumber: module.id,
                      ),
                    ),
                  ),
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A24),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isCurrent
                    ? const Color(0xFF3B82F6)
                    : Colors.white.withOpacity(0.05),
                width: isCurrent ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: module.color.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        module.icon,
                        color: module.color,
                        size: 28,
                      ),
                    ),
                    if (isCompleted)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF22C55E),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF1A1A24),
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ),
                    if (isLocked)
                      Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.lock,
                          color: Colors.white54,
                          size: 24,
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Module ${module.id}',
                            style: TextStyle(
                              color: module.color,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (isCurrent)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF3B82F6).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'IN PROGRESS',
                                style: TextStyle(
                                  color: Color(0xFF3B82F6),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        module.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Colors.white.withOpacity(0.4),
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            module.duration,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                              fontSize: 12,
                            ),
                          ),
                          if (isCompleted && score != null) ...[
                            const SizedBox(width: 16),
                            Icon(
                              Icons.star,
                              color: score >= 90 ? Colors.amber : Colors.orange,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$score%',
                              style: TextStyle(
                                color: score >= 90 ? Colors.amber : Colors.orange,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  isLocked ? Icons.lock : Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.3),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      )
          .animate()
          .fadeIn(delay: Duration(milliseconds: 100 * module.id), duration: 400.ms)
          .slideX(begin: -0.2, end: 0),
    );
  }

  void _showCourseInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          'Course Information',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Complete all 12 modules to earn your Advanced Responder certification.',
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(Icons.assignment, 'Pass each quiz with 90% or higher'),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.lock_open, 'Modules unlock sequentially'),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.timer, 'Estimated total time: 5-6 hours'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Got it',
              style: TextStyle(color: Color(0xFF3B82F6)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF3B82F6), size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13),
          ),
        ),
      ],
    );
  }
}