import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'VoiceCare/Voice_Input.dart';
import 'VoiceCare/Health_Log_Ui.dart';
import 'VoiceCare/healthinsights_ui.dart';
import 'VoiceCare/Reminder_Ui.dart';
import 'VoiceCare/setting_ui.dart';

void main() {
  runApp(VoiceCareApp());
}

class VoiceCareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HealthLogData>(
      create: (context) => HealthLogData(),
      child: MaterialApp(
        title: 'VoiceCare',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            elevation: 2,
          ),
        ),
        home: VoiceInputScreen(), // Your main/home screen
        routes: {
          '/voiceinput': (context) => VoiceInputScreen(),
          '/healthlog': (context) => HealthLogPage(),
          '/healthinsights': (context) => HealthInsightsPage(),
          '/reminder': (context) => MedicationReminderScreen(),
          '/settings': (context) => VoiceCareSettings(),
        },
      ),
    );
  }
}