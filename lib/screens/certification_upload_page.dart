import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CertificationUploadPage extends StatelessWidget {
  const CertificationUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color scaffoldBg = Color(0xFF0A0A0F);
    const Color primaryRed = Color(0xFFFF3B5C);
    const Color cardBg = Color(0xFF13131A);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Certifications',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Progress Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'STEP 1 OF 3',
                  style: TextStyle(color: primaryRed, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1),
                ),
                Text(
                  '33% Complete',
                  style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Credential Verification',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 12),
            Stack(
              children: [
                Container(
                  height: 6,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(3)),
                ),
                Container(
                  height: 6,
                  width: MediaQuery.of(context).size.width * 0.33,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [primaryRed, Color(0xFFC0243F)]),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 40),
            _buildSectionLabel('Document Upload'),
            const SizedBox(height: 16),
            
            // Upload Dropzone
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.1), style: BorderStyle.none), // Mocking dotted border with a container
              ),
              child: CustomPaint(
                painter: _DashedBorderPainter(color: Colors.white.withOpacity(0.2)),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: primaryRed.withOpacity(0.1), shape: BoxShape.circle),
                      child: const Icon(Icons.cloud_upload_rounded, color: primaryRed, size: 32),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Upload Certificate Image',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Supports PDF, JPG, or PNG (Max 10MB)',
                      style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13),
                    ),
                    const SizedBox(height: 24),
                    _buildSelectFileButton(),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),
            _buildFieldLabel('Certification Type'),
            _buildDropdownField('Select credential type'),
            
            const SizedBox(height: 24),
            _buildFieldLabel('Certificate Number'),
            _buildTextField('e.g. 12345-ABCDE'),
            
            const SizedBox(height: 24),
            _buildFieldLabel('Issuing Organization'),
            _buildTextField('e.g. American Red Cross'),
            
            const SizedBox(height: 24),
            _buildFieldLabel('Expiry Date'),
            _buildDatePickerField('mm/dd/yyyy'),

            const SizedBox(height: 32),
            _buildInfoBox(),
            
            const SizedBox(height: 40),
            _buildNextStepButton(),
            const SizedBox(height: 40),
          ],
        ),
      ).animate().fadeIn(duration: 600.ms),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 15, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A24),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.2)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildDropdownField(String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A24),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(hint, style: TextStyle(color: Colors.white.withOpacity(0.2))),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white24),
          dropdownColor: const Color(0xFF1A1A24),
          items: const [],
          onChanged: (v) {},
        ),
      ),
    );
  }

  Widget _buildDatePickerField(String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A24),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(hint, style: TextStyle(color: Colors.white.withOpacity(0.2))),
          Icon(Icons.calendar_today_rounded, color: Colors.white.withOpacity(0.4), size: 20),
        ],
      ),
    );
  }

  Widget _buildSelectFileButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFF3B5C), Color(0xFFC0243F)]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        'Select File',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFF3B5C).withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFF3B5C).withOpacity(0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_rounded, color: Color(0xFFFF3B5C), size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Your certification will be manually verified by our medical compliance team. Verification typically takes 12-24 hours.',
              style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextStepButton() {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFF3B5C), Color(0xFFC0243F)]),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: const Color(0xFFFF3B5C).withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 8)),
        ],
      ),
      child: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Next Step', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
            SizedBox(width: 10),
            Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  _DashedBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dashWidth = 8.0;
    const dashSpace = 6.0;
    final rrect = RRect.fromLTRBR(0, 0, size.width, size.height, const Radius.circular(24));
    final path = Path()..addRRect(rrect);

    for (var i = 0; i < path.computeMetrics().length; i++) {
      final metric = path.computeMetrics().elementAt(i);
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}