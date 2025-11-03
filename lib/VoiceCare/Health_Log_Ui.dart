import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// --- DATA MODELS ---

/// Represents a single log entry in the health log.
class LogEntry {
  final IconData icon;
  final String title;
  final String subtitle;
  const LogEntry({required this.icon, required this.title, required this.subtitle});
}

/// Represents the data for the weekly voice care report card.
class WeeklyReportData {
  final String title;
  final String status;
  final String summaryDuration;
  final String change;
  final List<double> graphPoints; // Normalized Y values (e.g., 0.0 to 1.0)
  final List<String> graphLabels; // Day labels for the graph
  final Color changeColor;

  const WeeklyReportData({
    required this.title,
    required this.status,
    required this.summaryDuration,
    required this.change,
    required this.graphPoints,
    required this.graphLabels,
    this.changeColor = Colors.greenAccent, // Default color for positive change
  });
}

/// Manages the overall health log data, including daily logs and weekly reports.
class HealthLogData extends ChangeNotifier {
  final List<LogEntry> _todayLogs;
  final List<LogEntry> _yesterdayLogs;
  final WeeklyReportData _weeklyReport;

  HealthLogData()
      : _todayLogs = <LogEntry>[
          const LogEntry(icon: Icons.medication, title: "Ibuprofen 200mg", subtitle: "Today, 1:03 PM"),
          const LogEntry(icon: Icons.sentiment_dissatisfied, title: "Headache", subtitle: "Today, 12:45 PM"),
        ],
        _yesterdayLogs = <LogEntry>[
          const LogEntry(icon: Icons.directions_walk, title: "30-min walk", subtitle: "Yesterday, 5:30 PM"),
          const LogEntry(icon: Icons.monitor_heart, title: "Heart Rate: 72 bpm", subtitle: "Yesterday, 9:15 AM"),
          const LogEntry(icon: Icons.medication, title: "Took Paracetamol", subtitle: "Yesterday, 8:00 AM"),
        ],
        _weeklyReport = WeeklyReportData(
          title: "Your Weekly VoiceCare Report",
          status: "Stable",
          summaryDuration: "Last 7 Days",
          change: "+2%",
          graphPoints: <double>[
            0.3, 0.7, 0.6, 0.75, 0.3, 0.6, 0.1
          ],
          graphLabels: <String>[
            "Mon",
            "Tue",
            "Wed",
            "Thu",
            "Fri",
            "Sat",
            "Sun"
          ],
        );

  List<LogEntry> get todayLogs => _todayLogs;
  List<LogEntry> get yesterdayLogs => _yesterdayLogs;
  WeeklyReportData get weeklyReport => _weeklyReport;
}

// --- WIDGET REFACTORING ---

/// Displays the weekly voice care report summary and graph.
class WeeklyReportCard extends StatelessWidget {
  final WeeklyReportData reportData;

  const WeeklyReportCard({super.key, required this.reportData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(reportData.title, style: const TextStyle(color: Colors.white70, fontSize: 16)),
          const SizedBox(height: 8),
          Text(reportData.status,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(
            children: <Widget>[
              Text(reportData.summaryDuration,
                  style: const TextStyle(color: Colors.white54, fontSize: 14)),
              const SizedBox(width: 6),
              Text(reportData.change,
                  style: TextStyle(color: reportData.changeColor, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: <Color>[
                  const Color(0xFFFFD54F).withAlpha((255 * 0.25).round()),
                  Colors.transparent
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: CustomPaint(painter: GraphPainter(reportData.graphPoints)),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: reportData.graphLabels
                .map<Widget>((String label) => Text(label, style: const TextStyle(color: Colors.white54, fontSize: 13)))
                .toList(),
          )
        ],
      ),
    );
  }
}

/// Displays a section title with a decorative line.
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Expanded(
            child: Container(height: 1, color: Colors.amber.withAlpha((255 * 0.3).round()))),
      ],
    );
  }
}

/// Displays a single log entry with an icon, title, and subtitle.
class LogCard extends StatelessWidget {
  final LogEntry entry;

  const LogCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF333333),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(entry.icon, color: const Color(0xFFFFD54F), size: 30),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(entry.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              Text(entry.subtitle,
                  style: const TextStyle(color: Colors.white54, fontSize: 13)),
            ],
          )
        ],
      ),
    );
  }
}

/// Custom painter for drawing the health report graph.
class GraphPainter extends CustomPainter {
  final List<double> points; // Normalized Y values (0.0 to 1.0)

  GraphPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) {
      return;
    }

    final Paint paint = Paint()
      ..color = const Color(0xFFFFD54F)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Path path = Path();

    final List<Offset> actualPoints = points.asMap().entries.map<Offset>((MapEntry<int, double> entry) {
      final int index = entry.key;
      final double normalizedY = entry.value;
      final double x = (size.width / (points.length - 1)) * index;
      final double y = size.height * (1.0 - normalizedY);
      return Offset(x, y);
    }).toList();

    path.moveTo(actualPoints.first.dx, actualPoints.first.dy);
    for (int i = 1; i < actualPoints.length; i++) {
      path.lineTo(actualPoints[i].dx, actualPoints[i].dy);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant GraphPainter oldDelegate) {
    return oldDelegate.points != points;
  }
}

/// The main health log display page.
class HealthLogPage extends StatelessWidget {
  const HealthLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HealthLogData healthLogData = context.watch<HealthLogData>();

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                "VOICECARE",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1.2),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.withAlpha((255 * 0.2).round()),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                ),
                onPressed: () {
                  print("Read My Summary button pressed.");
                },
                child: const Text(
                  "Read My Summary",
                  style: TextStyle(
                      color: Color(0xFFFFD54F),
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
              const SizedBox(height: 24),
              WeeklyReportCard(reportData: healthLogData.weeklyReport),
              const SizedBox(height: 24),
              const SectionTitle(title: "Today"),
              ...healthLogData.todayLogs
                  .map<Widget>((LogEntry entry) => LogCard(entry: entry))
                  .toList(),
              const SizedBox(height: 20),
              const SectionTitle(title: "Yesterday"),
              ...healthLogData.yesterdayLogs
                  .map<Widget>((LogEntry entry) => LogCard(entry: entry))
                  .toList(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Floating Action Button (mic) pressed.");
        },
        backgroundColor: const Color(0xFFFFD54F),
        child: const Icon(Icons.mic, color: Colors.black, size: 32),
      ),
    );
  }
}