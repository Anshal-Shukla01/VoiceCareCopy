import 'package:flutter/material.dart';
// import 'dart:math' as math; // For basic math operations if needed, not strictly for this graph - Removed unused import

// --- Main function to make this file executable ---
void main() {
  runApp(const VocoHealthInsightsApp());
}

// --- App Wrapper to provide a theme and home ---
class VocoHealthInsightsApp extends StatelessWidget {
  const VocoHealthInsightsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Insights',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212), // True black background
        fontFamily: 'Inter', // A clean, accessible font
      ),
      debugShowCheckedModeBanner: false,
      home: const HealthInsightsPage(),
    );
  }
}

// --- Your Refined HealthInsightsPage ---

class HealthInsightsPage extends StatelessWidget {
  const HealthInsightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // --- Defined theme colors from your previous code and image ---
    const primary = Color(0xFFFFD54F); // Bright, friendly yellow for accents
    const backgroundDark = Color(0xFF121212); // True black
    const cardDark = Color(0xFF1F1F1F); // Dark grey for cards
    const textDark = Colors.white;
    const textMutedDark = Color(0xFFA0A0A0); // Grey for subtitles/less important text
    const progressTrackDark = Color(0xFF333333); // Darker grey for progress bar backgrounds

    return Scaffold(
      backgroundColor: backgroundDark,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 450), // Max width for tablet/web view
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              children: [
                // --- Top Branding / Title ---
                const Text(
                  'VOICECARE',
                  style: TextStyle(
                    color: textMutedDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'My Health Insights',
                  style: TextStyle(
                    color: textDark,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),

                // --- Summary Card: Symptoms Decreased ---
                _SummaryCard(
                  cardColor: cardDark,
                  textColor: textDark,
                  textMutedColor: textMutedDark,
                  title: 'Symptoms decreased by 15% this week',
                  description: 'A positive trend in your vocal health journey. Keep up the great work!',
                ),
                const SizedBox(height: 16),

                // --- Weekly Wellness Trend Card (with Graph) ---
                _WellnessTrendCard(
                  cardColor: cardDark,
                  textColor: textDark,
                  textMutedColor: textMutedDark,
                  primaryColor: primary,
                ),
                const SizedBox(height: 24),

                // --- Top Symptoms This Week Section ---
                Text(
                  'Top Symptoms This Week',
                  style: TextStyle(
                    color: textMutedDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                _SymptomProgressBar(
                  symptom: 'Hoarseness',
                  progress: 0.8, // Example value
                  primaryColor: primary,
                  trackColor: progressTrackDark,
                  textColor: textDark,
                ),
                const SizedBox(height: 12),
                _SymptomProgressBar(
                  symptom: 'Cough',
                  progress: 0.65, // Example value
                  primaryColor: primary,
                  trackColor: progressTrackDark,
                  textColor: textDark,
                ),
                const SizedBox(height: 12),
                _SymptomProgressBar(
                  symptom: 'Sore Throat',
                  progress: 0.4, // Example value
                  primaryColor: primary,
                  trackColor: progressTrackDark,
                  textColor: textDark,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Custom Widget for the Summary Card ---
class _SummaryCard extends StatelessWidget {
  final Color cardColor;
  final Color textColor;
  final Color textMutedColor;
  final String title;
  final String description;

  const _SummaryCard({
    required this.cardColor,
    required this.textColor,
    required this.textMutedColor,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: textMutedColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// --- Custom Widget for the Weekly Wellness Trend Card (with graph) ---
class _WellnessTrendCard extends StatelessWidget {
  final Color cardColor;
  final Color textColor;
  final Color textMutedColor;
  final Color primaryColor; // This is the field that holds the primary color

  const _WellnessTrendCard({
    required this.cardColor,
    required this.textColor,
    required this.textMutedColor,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Wellness Trend',
            style: TextStyle(
              color: textMutedColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '7 Day Avg',
                style: TextStyle(
                  color: textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '-5%', // This would be dynamic in a real app
                style: TextStyle(
                  color: Colors.greenAccent, // Green for improvement
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                'This Week',
                style: TextStyle(
                  color: textMutedColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // --- Graph Section ---
          SizedBox(
            height: 100, // Fixed height for the graph
            width: double.infinity,
            child: CustomPaint(
              painter: _LineGraphPainter(
                graphColor: primaryColor, // Corrected: Used primaryColor field
                lineCount: 7, // For 7 days
              ),
            ),
          ),
          const SizedBox(height: 16),
          // --- Day Labels ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text('Mon', style: TextStyle(color: Color(0xFF616161), fontSize: 12)),
              Text('Tue', style: TextStyle(color: Color(0xFF616161), fontSize: 12)),
              Text('Wed', style: TextStyle(color: Color(0xFF616161), fontSize: 12)),
              Text('Thu', style: TextStyle(color: Color(0xFF616161), fontSize: 12)),
              Text('Fri', style: TextStyle(color: Color(0xFF616161), fontSize: 12)),
              Text('Sat', style: TextStyle(color: Color(0xFF616161), fontSize: 12)),
              Text('Sun', style: TextStyle(color: Color(0xFF616161), fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

// --- Custom Painter for the Line Graph ---
class _LineGraphPainter extends CustomPainter {
  final Color graphColor;
  final int lineCount; // Number of points on the graph

  _LineGraphPainter({required this.graphColor, required this.lineCount});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = graphColor
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();

    // Example data points (normalized to 0-1 range for graph height)
    // This would be real data in a production app
    const List<double> data = [0.4, 0.6, 0.3, 0.7, 0.5, 0.8, 0.4];

    // Calculate horizontal spacing
    final double stepX = size.width / (lineCount - 1);

    // Start drawing the path
    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;
      // Invert y-axis for standard graph appearance (0 at bottom, 1 at top)
      final y = size.height * (1 - data[i]); 

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Only repaint if data changes, for now it's static
  }
}

// --- Custom Widget for Symptom Progress Bars ---
class _SymptomProgressBar extends StatelessWidget {
  final String symptom;
  final double progress; // 0.0 to 1.0
  final Color primaryColor;
  final Color trackColor;
  final Color textColor;

  const _SymptomProgressBar({
    required this.symptom,
    required this.progress,
    required this.primaryColor,
    required this.trackColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          symptom,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: trackColor,
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            minHeight: 10, // Height of the progress bar
          ),
        ),
      ],
    );
  }
}