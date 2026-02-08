// import 'package:flutter/material.dart';
// import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
// import 'package:vector_math/vector_math_64.dart' as vector;
// import '../../../../shared/presentation/widgets/glassmorphic_card.dart';
// import 'package:go_router/go_router.dart';

// class ARTrainingPage extends StatefulWidget {
//   final String moduleId;

//   const ARTrainingPage({required this.moduleId, Key? key}) : super(key: key);

//   @override
//   State<ARTrainingPage> createState() => _ARTrainingPageState();
// }

// class _ARTrainingPageState extends State<ARTrainingPage> {
//   ArCoreController? arCoreController;
//   bool _isARSupported = false;
//   bool _isLoading = true;
//   String _currentInstruction = 'Point your camera at a flat surface';
//   String? _currentNodeName;
//   double _currentScale = 1.0;
//   double _currentRotation = 0.0;
//   vector.Vector3? _objectPosition;
//   vector.Vector4? _objectRotation;

//   @override
//   void initState() {
//     super.initState();
//     _checkARSupport();
//   }

//   Future<void> _checkARSupport() async {
//     try {
//       // Requires arcore_flutter_plugin ^0.1.0+ (null-safe)
//       final isSupported = await ArCoreController.checkArCoreAvailability();
//       if (mounted) {
//         setState(() {
//           _isARSupported = isSupported;
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       debugPrint('Error checking AR support: $e');
//       if (mounted) {
//         setState(() {
//           _isARSupported = false;
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   void _onArCoreViewCreated(ArCoreController controller) {
//     arCoreController = controller;
//     arCoreController!.onPlaneTap = _handlePlaneTap;
//     arCoreController!.onNodeTap = _handleNodeTap;

//     setState(() {
//       _currentInstruction = 'Tap on a surface to place the training object';
//     });
//   }

//   void _handlePlaneTap(List<ArCoreHitTestResult> hits) {
//     if (hits.isNotEmpty) {
//       final hit = hits.first;
//       _addARObject(hit);
//     }
//   }

//   void _handleNodeTap(String nodeName) {
//     setState(() {
//       _currentInstruction = 'Use controls below to interact with the object';
//     });
//   }

//   void _addARObject(ArCoreHitTestResult hit) {
//     try {
//       // Remove previous node if exists
//       if (_currentNodeName != null && arCoreController != null) {
//         arCoreController!.removeNode(nodeName: _currentNodeName!);
//       }

//       // Store position and rotation
//       _objectPosition = vector.Vector3(
//         hit.pose.translation.x,
//         hit.pose.translation.y,
//         hit.pose.translation.z,
//       );
//       _objectRotation = vector.Vector4(
//         hit.pose.rotation.a,
//         hit.pose.rotation.b,
//         hit.pose.rotation.g,
//         hit.pose.rotation.p,
//       );

//       _currentNodeName =
//           'training_object_${DateTime.now().millisecondsSinceEpoch}';
//       _addNodeToScene();

//       setState(() {
//         _currentInstruction = 'Object placed! Use controls to interact';
//       });
//     } catch (e) {
//       debugPrint('Error adding AR objects: $e');
//       setState(() {
//         _currentInstruction = 'Error placing object. Try again.';
//       });
//     }
//   }

//   void _addNodeToScene() {
//     if (_objectPosition == null || _currentNodeName == null) return;

//     final material = ArCoreMaterial(
//       color: const Color(0xFF00FF64),
//       metallic: 0.8,
//     );

//     ArCoreNode node;

//     switch (widget.moduleId.toLowerCase()) {
//       case 'welding':
//         node = ArCoreNode(
//           shape: ArCoreCube(
//             materials: [material],
//             size: vector.Vector3.all(0.15 * _currentScale),
//           ),
//           position: _objectPosition!,
//           rotation: _objectRotation ?? vector.Vector4(0, 1, 0, 0),
//         );
//         break;
//       case 'assembly':
//         node = ArCoreNode(
//           shape: ArCoreCylinder(
//             materials: [material],
//             radius: 0.1 * _currentScale,
//             height: 0.2 * _currentScale,
//           ),
//           position: _objectPosition!,
//           rotation: _objectRotation ?? vector.Vector4(0, 1, 0, 0),
//         );
//         break;
//       default:
//         node = ArCoreNode(
//           shape: ArCoreSphere(
//             materials: [material],
//             radius: 0.1 * _currentScale,
//           ),
//           position: _objectPosition!,
//           rotation: _objectRotation ?? vector.Vector4(0, 1, 0, 0),
//         );
//     }

//     arCoreController?.addArCoreNodeToAugmentedImage(
//       node,
//       _currentNodeName!.length,
//     );
//   }

//   void _rotateObject() {
//     if (_currentNodeName != null &&
//         arCoreController != null &&
//         _objectPosition != null) {
//       try {
//         setState(() {
//           _currentRotation += 45;
//         });

//         // Update rotation
//         final radians = _currentRotation * (3.14159 / 180);
//         _objectRotation = vector.Vector4(0, 1, 0, radians);

//         // Remove and recreate
//         arCoreController!.removeNode(nodeName: _currentNodeName!);
//         _currentNodeName =
//             'training_object_${DateTime.now().millisecondsSinceEpoch}';
//         _addNodeToScene();

//         setState(() {
//           _currentInstruction = 'Object rotated ${_currentRotation.toInt()}°';
//         });
//       } catch (e) {
//         debugPrint('Error rotating object: $e');
//       }
//     }
//   }

//   void _zoomObject() {
//     if (_currentNodeName != null &&
//         arCoreController != null &&
//         _objectPosition != null) {
//       try {
//         setState(() {
//           _currentScale = _currentScale >= 2.0 ? 0.5 : _currentScale + 0.25;
//         });

//         // Remove and recreate with new scale
//         arCoreController!.removeNode(nodeName: _currentNodeName!);
//         _currentNodeName =
//             'training_object_${DateTime.now().millisecondsSinceEpoch}';
//         _addNodeToScene();

//         setState(() {
//           _currentInstruction = 'Scale: ${(_currentScale * 100).toInt()}%';
//         });
//       } catch (e) {
//         debugPrint('Error scaling object: $e');
//       }
//     }
//   }

//   void _showObjectInfo() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: const Color(0xFF1C1C1E),
//         title: const Text(
//           'Training Object Info',
//           style: TextStyle(color: Colors.white),
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _InfoRow('Module', widget.moduleId.toUpperCase()),
//             const SizedBox(height: 8),
//             _InfoRow('Rotation', '${_currentRotation.toInt()}°'),
//             const SizedBox(height: 8),
//             _InfoRow('Scale', '${(_currentScale * 100).toInt()}%'),
//             const SizedBox(height: 8),
//             _InfoRow(
//               'Status',
//               _currentNodeName != null ? 'Placed' : 'Not Placed',
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text(
//               'Close',
//               style: TextStyle(color: Color(0xFF00FF64)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     arCoreController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bottomPadding = MediaQuery.of(context).padding.bottom;

//     return Scaffold(
//       backgroundColor: const Color(0xFF0A0A0F),
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: Container(
//           margin: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: Colors.black.withOpacity(0.5),
//             shape: BoxShape.circle,
//           ),
//           child: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () => context.pop(),
//           ),
//         ),
//         title: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           decoration: BoxDecoration(
//             color: Colors.black.withOpacity(0.5),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Text(
//             'AR Training - ${widget.moduleId.toUpperCase()}',
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: _isLoading
//           ? const Center(
//               child: CircularProgressIndicator(color: Color(0xFF00FF64)),
//             )
//           : _isARSupported
//           ? Stack(
//               children: [
//                 ArCoreView(
//                   onArCoreViewCreated: _onArCoreViewCreated,
//                   enableTapRecognizer: true,
//                 ),
//                 // Instruction banner at top
//                 Positioned(
//                   top: kToolbarHeight + MediaQuery.of(context).padding.top + 8,
//                   left: 16,
//                   right: 16,
//                   child: GlassmorphicCard(
//                     padding: const EdgeInsets.all(12),
//                     child: Row(
//                       children: [
//                         const Icon(
//                           Icons.info_outline,
//                           color: Color(0xFF00FF64),
//                           size: 20,
//                         ),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           child: Text(
//                             _currentInstruction,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 13,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // Controls at bottom
//                 Positioned(
//                   left: 0,
//                   right: 0,
//                   bottom: 0,
//                   child: _buildControls(bottomPadding),
//                 ),
//               ],
//             )
//           : _buildARNotSupported(),
//     );
//   }

//   Widget _buildControls(double bottomPadding) {
//     return Container(
//       padding: EdgeInsets.only(
//         left: 16,
//         right: 16,
//         top: 16,
//         bottom: bottomPadding + 16,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           GlassmorphicCard(
//             padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _ControlButton(
//                   icon: Icons.rotate_left,
//                   label: 'Rotate',
//                   onTap: _rotateObject,
//                   isEnabled: _currentNodeName != null,
//                 ),
//                 _ControlButton(
//                   icon: Icons.zoom_in,
//                   label: 'Scale',
//                   onTap: _zoomObject,
//                   isEnabled: _currentNodeName != null,
//                 ),
//                 _ControlButton(
//                   icon: Icons.info,
//                   label: 'Info',
//                   onTap: _showObjectInfo,
//                   isEnabled: true,
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 12),
//           SizedBox(
//             width: double.infinity,
//             child: GlassmorphicCard(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               onTap: () {
//                 // Show completion dialog
//                 showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     backgroundColor: const Color(0xFF1C1C1E),
//                     title: const Text(
//                       'Complete Training?',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     content: const Text(
//                       'Mark this training module as complete?',
//                       style: TextStyle(color: Colors.white70),
//                     ),
//                     actions: [
//                       TextButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: const Text(
//                           'Cancel',
//                           style: TextStyle(color: Colors.white70),
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                           context.pop();
//                         },
//                         child: const Text(
//                           'Complete',
//                           style: TextStyle(color: Color(0xFF30D158)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.check_circle, color: Color(0xFF30D158), size: 22),
//                   SizedBox(width: 8),
//                   Text(
//                     'Complete Training',
//                     style: TextStyle(
//                       color: Color(0xFF30D158),
//                       fontWeight: FontWeight.w600,
//                       fontSize: 15,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildARNotSupported() {
//     return SafeArea(
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(24),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.white.withOpacity(0.1),
//                 ),
//                 child: Icon(
//                   Icons.warning_amber_rounded,
//                   color: Colors.white.withOpacity(0.5),
//                   size: 64,
//                 ),
//               ),
//               const SizedBox(height: 24),
//               const Text(
//                 'AR Not Supported',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 'This device does not support ARCore.\nPlease use a compatible Android device.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.white.withOpacity(0.7),
//                   fontSize: 16,
//                   height: 1.5,
//                 ),
//               ),
//               const SizedBox(height: 32),
//               SizedBox(
//                 width: double.infinity,
//                 child: GlassmorphicCard(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 32,
//                     vertical: 16,
//                   ),
//                   onTap: () => context.pop(),
//                   child: const Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.arrow_back, color: Color(0xFF00FF64)),
//                       SizedBox(width: 8),
//                       Text(
//                         'Go Back',
//                         style: TextStyle(
//                           color: Color(0xFF00FF64),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _ControlButton extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback onTap;
//   final bool isEnabled;

//   const _ControlButton({
//     required this.icon,
//     required this.label,
//     required this.onTap,
//     this.isEnabled = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Opacity(
//       opacity: isEnabled ? 1.0 : 0.4,
//       child: GestureDetector(
//         onTap: isEnabled ? onTap : null,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 56,
//               height: 56,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: isEnabled
//                     ? LinearGradient(
//                         colors: [
//                           const Color(0xFF5856D6).withOpacity(0.4),
//                           const Color(0xFF5856D6).withOpacity(0.2),
//                         ],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       )
//                     : null,
//                 color: isEnabled ? null : Colors.white.withOpacity(0.1),
//                 border: Border.all(
//                   color: isEnabled
//                       ? const Color(0xFF5856D6).withOpacity(0.6)
//                       : Colors.white.withOpacity(0.2),
//                   width: 1.5,
//                 ),
//               ),
//               child: Icon(icon, color: Colors.white, size: 24),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               label,
//               style: TextStyle(
//                 color: Colors.white.withOpacity(isEnabled ? 0.9 : 0.5),
//                 fontSize: 13,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _InfoRow extends StatelessWidget {
//   final String label;
//   final String value;

//   const _InfoRow(this.label, this.value);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
//         ),
//         Text(
//           value,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }
// }

// NOTE: arcore_flutter_plugin requires a namespace; see android/build.gradle subprojects hook.
// NOTE: Build uses android/build.gradle subprojects hook to set plugin namespace.
