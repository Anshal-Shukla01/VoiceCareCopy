
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medication Reminder',
      theme: ThemeData(
        // Define a dark theme or use the backgroundDark color
        scaffoldBackgroundColor: const Color(0xFF121212),
        brightness: Brightness.dark,
        colorSchemeSeed: const Color(0xFFFFD54F), // A base color for generating the scheme
        useMaterial3: true,
      ),
      home: const MedicationReminderScreen(),
    );
  }
}

class MedicationReminderScreen extends StatelessWidget {
  const MedicationReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFFFD54F);
    const Color backgroundDark = Color(0xFF121212);

    return Scaffold(
      backgroundColor: backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'VOICECARE',
                style: GoogleFonts.inter(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                  fontSize: 20,
                  // Added a font fallback for robustness against elusive font loading issues.
                ).copyWith(
                  fontFamilyFallback: const ['sans-serif'],
                ),
              ),
              const Spacer(),
              Text(
                "It's time for your medication",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  // Added a font fallback for robustness against elusive font loading issues.
                ).copyWith(
                  fontFamilyFallback: const ['sans-serif'],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Lantus Insulin, 20 units',
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 16,
                  // Added a font fallback for robustness against elusive font loading issues.
                ).copyWith(
                  fontFamilyFallback: const ['sans-serif'],
                ),
              ),
              const SizedBox(height: 50),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha((primaryColor.a * 0.3).round()),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withAlpha((primaryColor.a * 0.2).round()),
                          blurRadius: 60,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.schedule,
                    size: 90,
                    color: Colors.white,
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: backgroundDark,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      // Handle "TAKEN" action
                    },
                    child: const Text(
                      "TAKEN",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: primaryColor, width: 2),
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      // Handle "SKIP" action
                    },
                    child: const Text(
                      "SKIP",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Single tap for Taken, Double tap to Close",
                    style: GoogleFonts.poppins(
                      color: Colors.white38,
                      fontSize: 12,
                      // Added a font fallback for robustness against elusive font loading issues.
                    ).copyWith(
                      fontFamilyFallback: const ['sans-serif'],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
