import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../shared/presentation/widgets/glassmorphic_card.dart';

class TrainingPage extends StatelessWidget {
  const TrainingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final modules = [
      {
        'title': 'CPR Basics',
        'description': 'Learn cardiopulmonary resuscitation',
        'icon': Icons.favorite,
        'duration': '15 min',
        'progress': 0.6,
      },
      {
        'title': 'First Aid Kit',
        'description': 'Essential first aid supplies',
        'icon': Icons.medical_services,
        'duration': '10 min',
        'progress': 0.0,
      },
      {
        'title': 'Wound Care',
        'description': 'Treating cuts and injuries',
        'icon': Icons.healing,
        'duration': '12 min',
        'progress': 1.0,
      },
      {
        'title': 'Choking Relief',
        'description': 'Heimlich maneuver guide',
        'icon': Icons.air,
        'duration': '8 min',
        'progress': 0.3,
      },
      {
        'title': 'Recovery Position',
        'description': 'How to position an injured person',
        'icon': Icons.accessibility,
        'duration': '7 min',
        'progress': 0.0,
      },
      {
        'title': 'Burn Treatment',
        'description': 'Handling thermal injuries',
        'icon': Icons.local_fire_department,
        'duration': '9 min',
        'progress': 0.8,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: const Color(0xFF0A0A0F),
            elevation: 0,
            title: const Text(
              'Training Modules',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.95,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final module = modules[index];
                return _ModuleCard(
                  module: module,
                  index: index,
                ).animate().scale(
                  duration: 400.ms,
                  delay: (index * 50).ms,
                  begin: const Offset(0.8, 0.8),
                );
              }, childCount: modules.length),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final Map<String, dynamic> module;
  final int index;

  const _ModuleCard({required this.module, required this.index});

  @override
  Widget build(BuildContext context) {
    return GlassmorphicCard(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(0),
      onTap: () => context.push('/training/${module['title']}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF5856D6),
                  const Color(0xFF5856D6).withOpacity(0.5),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              module['icon'] as IconData,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            module['title'] as String,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            module['duration'] as String,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 12,
            ),
          ),
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: module['progress'] as double,
              minHeight: 4,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(
                (module['progress'] as double) == 1.0
                    ? const Color(0xFF30D158)
                    : const Color(0xFF00FF64),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
