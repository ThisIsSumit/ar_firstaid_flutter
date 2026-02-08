import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Note: This widget is ready for Rive integration
// Uncomment 'rive: ^0.14.2' in pubspec.yaml and run 'flutter pub get'
// Then uncomment the import and implementation below

// import 'package:rive/rive.dart';

class RiveAnimationWidget extends StatefulWidget {
  final String assetPath;
  final String? animationName;
  final String? stateMachineName;
  final BoxFit fit;
  final Alignment alignment;
  final bool autoplay;
  final VoidCallback? onInit;

  const RiveAnimationWidget({
    super.key,
    required this.assetPath,
    this.animationName,
    this.stateMachineName,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.autoplay = true,
    this.onInit,
  });

  @override
  State<RiveAnimationWidget> createState() => _RiveAnimationWidgetState();
}

class _RiveAnimationWidgetState extends State<RiveAnimationWidget> {
  // Artboard? _riveArtboard;
  // SMITrigger? _trigger;
  // SMIBool? _bool;
  // SMINumber? _number;

  @override
  void initState() {
    super.initState();
    _loadRiveFile();
  }

  Future<void> _loadRiveFile() async {
    // TODO: Uncomment when rive package is added
    /*
    try {
      final data = await rootBundle.load(widget.assetPath);
      final file = RiveFile.import(data);

      final artboard = file.mainArtboard;

      if (widget.stateMachineName != null) {
        final controller = StateMachineController.fromArtboard(
          artboard,
          widget.stateMachineName!,
        );

        if (controller != null) {
          artboard.addController(controller);

          // Get inputs for interaction
          _trigger = controller.findInput<bool>('Trigger') as SMITrigger?;
          _bool = controller.findInput<bool>('Boolean') as SMIBool?;
          _number = controller.findInput<double>('Number') as SMINumber?;
        }
      } else if (widget.animationName != null) {
        final controller = SimpleAnimation(widget.animationName!);
        artboard.addController(controller);
      }

      setState(() => _riveArtboard = artboard);

      if (widget.onInit != null) {
        widget.onInit!();
      }
    } catch (e) {
      debugPrint('Error loading Rive file: $e');
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Uncomment when rive package is added
    /*
    if (_riveArtboard == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Rive(
      artboard: _riveArtboard!,
      fit: widget.fit,
      alignment: widget.alignment,
    );
    */

    // Placeholder until Rive is enabled
    return Container(
      alignment: widget.alignment,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.animation, size: 64, color: Colors.white.withOpacity(0.3)),
          const SizedBox(height: 16),
          Text(
            'Rive Animation Placeholder',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.assetPath.split('/').last,
            style: TextStyle(
              color: Colors.white.withOpacity(0.3),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // Trigger methods for state machine interaction
  void trigger() {
    // _trigger?.fire();
  }

  void setBool(bool value) {
    // _bool?.value = value;
  }

  void setNumber(double value) {
    // _number?.value = value;
  }
}
